library(shiny)
library(shinyjs)
library(shinythemes)
library(shinydashboard)
library(shinyauthr)
library(sodium)
library(shinyalert)
library(DBI)
library(RPostgreSQL)
library(shinyBS)
library(DT)



con <- dbConnect(RPostgres::Postgres(),
                 dbname = 'pracownia', # nazwa naszej projektowej bazy
                 host = 'localhost',
                 port = '5432', # port ten sam co w psql - zwykle 5432
                 user = 'greyraven', # nasza nazwa uzytkownika psql
                 password = 'greyraven#') # i nasze haslo tego uzytkownika

# obiekty do rendertable do outputu w sekcji serwer;
# podstawowe tabele 
limity <- dbGetQuery(con, "SELECT * FROM limity")
przedmioty <- dbGetQuery(con, "SELECT * FROM przedmioty")
status_grupy <- dbGetQuery(con, "SELECT * FROM status_grupy")
typ_szkoly <- dbGetQuery(con, "SELECT * FROM typ_szkoly")
typ_kursu <- dbGetQuery(con, "SELECT * FROM typ_kursu")
termin_zajec <- dbGetQuery(con, "SELECT * FROM termin_zajec")
rodzaje_uzytkownikow <- dbGetQuery(con, "SELECT * FROM rodzaje_uzytkownikow")
uzytkownicy <- dbGetQuery(con, "SELECT * FROM uzytkownicy")
poziomy <- dbGetQuery(con, "SELECT * FROM poziomy")
ceny <- dbGetQuery(con, "SELECT * FROM ceny")
zajecia_uczniow <- dbGetQuery(con, "SELECT * FROM zajecia_uczniow")
terminy_zajec_grup <- dbGetQuery(con, "SELECT * FROM terminy_zajec_grup")
daty_kursu <- dbGetQuery(con, "SELECT * FROM daty_kursu")
grupy <- dbGetQuery(con, "SELECT * FROM grupy")



# Widoki
aktualnie_uczacy_nauczyciele <- dbGetQuery(con, "SELECT * FROM aktualnie_uczacy_nauczyciele")
aktualny_grafik_grup <- dbGetQuery(con, "SELECT * FROM aktualny_grafik_grup")
aktualny_grafik_zapisow <- dbGetQuery(con, "SELECT * FROM aktualny_grafik_zapisow")
aktualnie_rekrutujace_grupy <- dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy")
nauczyciele <- dbGetQuery(con, "SELECT * FROM nauczyciele")
uczniowie <- dbGetQuery(con, "SELECT * FROM uczniowie")

ladne_ceny <- dbGetQuery(con, "SELECT * FROM ceny_do_ogladania")
ladne_poziomy <- dbGetQuery(con, "SELECT * FROM poziomy_do_ogladania")
ladne_typy_kursow <- dbGetQuery(con, "SELECT nazwa FROM typ_kursu")
ladne_przedmioty <- dbGetQuery(con, "SELECT nazwa FROM przedmioty")

zapisy_info_grupy <- dbGetQuery(con, "SELECT * FROM zapisy_dalsze_info")
id_rek_grup <- dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id")


# Aplikacja ShinyDashboard
ui <- dashboardPage(
  dashboardHeader(title = "Szkoła Delta"),
  dashboardSidebar(
    # Zakładki w menu
    
    # Panel logowania
    hr(),
    titlePanel("Panel logowania"),
    textInput("username", "Login użytkownika"),
    passwordInput("password", "Hasło"),
    actionButton("login_button", "Zaloguj"),
    actionButton("logout_button", "Wyloguj"),
    actionButton("clearButton", "Wyczyść hasło"),
    hr(),
    
    # Dodaj tę sekcję w ui
    tags$head(
      tags$style(
        HTML(
          "
      .sidebar {
        overflow-y: auto !important;
        max-height: 911px;
      }
      "
        )
      )
    ),
    
    
    sidebarMenuOutput("dynamic_sidebar_buttons")
  
    
  ),
  dashboardBody(
    # Komunikaty na górze obszaru głównego
    tags$head(
      tags$style(
        HTML("
          .shiny-notification {
            position: fixed;
            top: 0;
            left: 50%;
            transform: translateX(-50%);
          }
        ")
      )
    ),
    # Dynamicznie renderowana zawartość strony
    uiOutput("main_content")
  )
)


server <- function(input, output, session) {
  
  # RENDERY do datatable do wyświetlenia
  
  # Główne tabele
  output$limity_lista = renderDataTable(limity)
  output$przedmioty_lista = renderDataTable(przedmioty)
  output$status_grupy_lista = renderDataTable(status_grupy)
  output$typ_szkoly_lista = renderDataTable(typ_szkoly)
  output$typ_kursu_lista = renderDataTable(typ_kursu)
  output$termin_zajec_lista = renderDataTable(termin_zajec)
  output$uzytkownicy_lista = renderDataTable(uzytkownicy)
  output$rodzaje_uzytkownikow_lista = renderDataTable(rodzaje_uzytkownikow)
  output$poziomy_lista = renderDataTable(poziomy)
  output$ceny_lista = renderDataTable(ceny)
  output$zajecia_uczniow_lista = renderDataTable(zajecia_uczniow)
  output$terminy_zajec_grup_lista = renderDataTable(terminy_zajec_grup)
  output$daty_kursu_lista = renderDataTable(daty_kursu)
  output$grupy_lista = renderDataTable(grupy)
  
  # Widoki
  output$aktualnie_uczacy_nauczyciele_lista = renderDataTable(aktualnie_uczacy_nauczyciele)
  output$aktualny_grafik_grup_lista = renderDataTable(aktualny_grafik_grup)
  output$aktualny_grafik_zapisow_lista = renderDataTable(aktualny_grafik_zapisow)
  output$aktualnie_rekrutujace_grupy_lista = renderDataTable(aktualnie_rekrutujace_grupy)
  output$nauczyciele_lista = renderDataTable(nauczyciele)
  output$uczniowie_lista = renderDataTable(uczniowie)
  
  output$ladne_ceny_lista = renderDataTable(ladne_ceny)
  output$ladne_poziomy_lista = renderDataTable(ladne_poziomy)
  output$ladne_typy_kursow_lista = renderDataTable(ladne_typy_kursow)
  output$ladne_przedmioty_lista = renderDataTable(ladne_przedmioty)
  
  output$zapisy_info_grupy_lista = renderDataTable(zapisy_info_grupy)
  output$id_rek_grup_lista = renderDataTable(id_rek_grup)
  
  
  
  
  # Uruchomienie shinyjs
  shinyjs::useShinyjs()
  
  
  # Dane użytkownika
  user_data <- reactiveVal(NULL)
  
  # Reaktywna zmienna do monitorowania zmian w polu hasła
  password_clear <- reactiveVal(FALSE)
  
  # funkcje tworzące widoki dla ucznia
  # Zmieniamy renderTable na renderDataTable
  output$dynamiczny_grafik_ucznia <- renderDataTable({
    req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
    
    # Pobieramy dane dla zalogowanego użytkownika
    data <- dbGetQuery(con, paste0("SELECT * from zajecia_ucznia(", user_data()$id, ")"))
    
    # Renderujemy DataTable
    datatable(data, options = list(
      paging = TRUE,  # Paginacja
      searching = TRUE,  # Wyszukiwanie
      ordering = TRUE,  # Sortowanie
      lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
      pageLength = 10,  # Domyślna liczba rekordów na stronie
      dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    ))
  })
  
  ########################
  # funkcje tworzące widoki dla nauczyciela
  # aktualne grupy
  output$dynamiczny_grafik_nauczyciela_aktualny <- renderDataTable({
    req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
    
    # Pobieramy dane dla zalogowanego użytkownika
    data <- dbGetQuery(con, paste0("SELECT * from statusy_grup_nauczyciela('aktywna',", user_data()$id, ")"))
    
    # Renderujemy DataTable
    datatable(data, options = list(
      paging = TRUE,  # Paginacja
      searching = TRUE,  # Wyszukiwanie
      ordering = TRUE,  # Sortowanie
      lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
      pageLength = 10,  # Domyślna liczba rekordów na stronie
      dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    ))
  })
  # planowane grupy
  output$dynamiczny_grafik_nauczyciela_plany <- renderDataTable({
    req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
    
    # Pobieramy dane dla zalogowanego użytkownika
    data <- dbGetQuery(con, paste0("SELECT * from statusy_grup_nauczyciela('planowana',", user_data()$id, ")"))
    
    # Renderujemy DataTable
    datatable(data, options = list(
      paging = TRUE,  # Paginacja
      searching = TRUE,  # Wyszukiwanie
      ordering = TRUE,  # Sortowanie
      lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
      pageLength = 10,  # Domyślna liczba rekordów na stronie
      dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    ))
  })
  # wszyscy uczniowie
  # planowane grupy
  output$dynamiczny_spis_uczniow <- renderDataTable({
    req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
    
    # Pobieramy dane dla zalogowanego użytkownika
    data <- dbGetQuery(con, paste0("SELECT * from moi_uczniowie(", user_data()$id, ")"))
    
    # Renderujemy DataTable
    datatable(data, options = list(
      paging = TRUE,  # Paginacja
      searching = TRUE,  # Wyszukiwanie
      ordering = TRUE,  # Sortowanie
      lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
      pageLength = 10,  # Domyślna liczba rekordów na stronie
      dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
      buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
    ))
  })
  
  
  # Przyciski dla nowych zakładek w pasku bocznym
  output$dynamic_sidebar_buttons <- renderMenu({
    if (!is.null(user_data())) {
      stopien_dostepu <- user_data()$stopien_uprawnien_uzytkownika
      dynamiczne_zakładki <- c()
      dynamiczne_zakladki <- get_dynamic_tabs(stopien_dostepu)
      
      if (length(dynamiczne_zakladki) > 0) {
        if(identical(dynamiczne_zakladki,c("Zakładka A", "Zakładka B"))){
          sidebarMenu(
            menuItem("Strona Główna", tabName = "strona_glowna", icon = icon("home")),
            menuItem("Użytkownicy", tabName = "uzytkownicy", icon=icon("users")),
            menuItem("Rodzaje użytkowników", tabName = "rodz_uzytkownikow", icon=icon("users-viewfinder")),
            menuItem("Grupy", tabName ="grupy2", icon=icon("list-ol")),
            menuItem("Terminy zajęć grup", tabName ="ter_zaj_grup", icon=icon("clipboard-list")),
            menuItem("Zajęcia uczniów", tabName ="gr_ucz", icon=icon("address-book")),
            menuItem("Daty kursów", tabName ="daty_kursow", icon=icon("calendar")),
            menuItem("Statusy grup", tabName ="st_grup", icon=icon("comment")),
            menuItem("Terminy zajęć", tabName ="ter_zaj", icon=icon("clock")),
            menuItem("Ceny kursów", tabName ="ceny2", icon=icon("dollar-sign")),
            menuItem("Limity miejsc", tabName ="lim_miejsc", icon=icon("lock")),
            menuItem("Typy szkół", tabName ="t_szkol", icon=icon("school")),
            menuItem("Typy kursów", tabName ="t_kursow", icon=icon("list")),
            menuItem("Poziomy kursów", tabName ="poziomy2", icon=icon("layer-group")),
            menuItem("Przedmioty", tabName ="przedmioty2", icon=icon("book"))
            )
        }else if(identical(dynamiczne_zakladki,c("Zakładka B", "Zakładka C"))){
          sidebarMenu(
            menuItem("Strona Główna", tabName = "strona_glowna", icon = icon("home")),
            menuItem("Mój grafik", tabName = "moj_grafik", icon=icon("calendar")),
            menuItem("Moi uczniowie", tabName = "moi_uczniowie", icon=icon("users")))
        } else {
          sidebarMenu(
            menuItem("Strona Główna", tabName = "strona_glowna", icon = icon("home")),
            menuItem("Moje grupy", tabName = "moje_grupy", icon=icon("user")),
            menuItem("Nowe grupy", tabName ="grupy1", icon=icon("users")),
            menuItem("Oferowane przedmioty", tabName ="przedmioty1", icon=icon("book")),
            menuItem("Oferowane poziomy", tabName ="poziomy1", icon=icon("list-ol")),
            menuItem("Oferowane typy kursów", tabName ="typ_kursu1", icon=icon("list-ol")),
            menuItem("Nauczyciele", tabName ="nauczyciele1", icon=icon("graduation-cap")),
            menuItem("Cennik", tabName ="cennik1", icon=icon("dollar-sign")))
        }
      } else {
        sidebarMenu(
          menuItem("Strona Główna", tabName = "strona_glowna", icon = icon("home")),
          menuItem("Rejestracja", tabName = "rejestracja", icon=icon("pen")),
          menuItem("Nowe grupy", tabName ="grupy1", icon=icon("users")),
          menuItem("Oferowane przedmioty", tabName ="przedmioty1", icon=icon("book")),
          menuItem("Oferowane poziomy", tabName ="poziomy1", icon=icon("list-ol")),
          menuItem("Oferowane typy kursów", tabName ="typ_kursu1", icon=icon("list-ol")),
          menuItem("Nauczyciele", tabName ="nauczyciele1", icon=icon("graduation-cap")),
          menuItem("Cennik", tabName ="cennik1", icon=icon("dollar-sign"))
        )
      }
    } else {
      sidebarMenu(
        menuItem("Strona Główna", tabName = "strona_glowna", icon = icon("home")),
        menuItem("Rejestracja", tabName = "rejestracja", icon=icon("pen")),
        menuItem("Nowe grupy",tabName ="grupy1" ,icon=icon("users")),
        menuItem("Oferowane przedmioty",tabName ="przedmioty1" ,icon=icon("book")),
        menuItem("Oferowane poziomy",tabName ="poziomy1" ,icon=icon("list-ol")),
        menuItem("Oferowane typy kursów",tabName ="typ_kursu1" ,icon=icon("list-ol")),
        menuItem("Nauczyciele",tabName ="nauczyciele1" ,icon=icon("graduation-cap")),
        menuItem("Cennik",tabName ="cennik1" ,icon=icon("dollar-sign"))
      )
    }
  })
  
  # Dynamiczne renderowanie zawartości zakładek w obszarze głównym
  output$main_content <- renderUI({
    if (!is.null(user_data())) {
      stopien_dostepu <- user_data()$stopien_uprawnien_uzytkownika
      dynamiczne_zakladki <- get_dynamic_tabs(stopien_dostepu)
      
      
      # Generowanie dynamicznych zakładek
      if (length(dynamiczne_zakladki) > 0) {
        if(identical(dynamiczne_zakladki,c("Zakładka A", "Zakładka B"))) {
          ####################################################### ADMINISTRATOR ########################################################################################
          tabItems(
            tabItem("strona_glowna", h2("Witamy w serwisie Szkoły Delta"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Nowe grupy",
                                         hr(),
                                         h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Oto grupy, w których zostały jeszcze wolne miejsca:"),
                                         hr(),
                                         dataTableOutput('aktualnie_rekrutujace_grupy_lista', width="80%"))
                              ))),
            tabItem("uzytkownicy", h2("Lista wszystkich użytkowników"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',hr(),
                              fluidRow(
                                column(3, actionButton("formularz_dod_nauczyciela", "Dodaj nauczyciela")),
                                column(3, actionButton("formularz_us_nauczyciela", "Zwolnij nauczyciela")),
                                column(3, actionButton("formularz_us_ucznia", "Usuń ucznia"))
                              ),
                              hr(),
                              tabsetPanel(
                                # tabela
                                tabPanel("Użytkownicy", dataTableOutput('uzytkownicy_lista', width="80%"))
                              ))),
            tabItem("rodz_uzytkownikow", h2("Rodzaje użytkowników"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',hr(),
                              fluidRow(
                                column(3, actionButton("formularz_dod_rodz_uzyt", "Dodaj rodzaj użytkownika")),
                                column(3, actionButton("formularz_us_r_uzyt", "Usuń rodzaj użytkownika"))
                              ),
                              hr(),
                              tabsetPanel(
                                # tabela
                                tabPanel("Rodzaje użytkowników", dataTableOutput('rodzaje_uzytkownikow_lista', width="80%")
                                         # Przycisk otwierający okno modalne
                                         #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                         )))),
            tabItem("grupy2", h2("Lista wszystkich grup"),
                            fluidPage(theme = shinytheme("flatly"),
                                      height = '100%',hr(),
                                      fluidRow(
                                        column(2, actionButton("dod_grupe", "Dodaj grupę")),
                                        column(2, actionButton("us_grupe", "Usuń grupę")),
                                        column(3, actionButton("zm_nau_gr", "Zmień nauczyciela grupy")),
                                        column(3, actionButton("zm_lim_gr", "Zmień limit osób w grupie")),
                                        column(2, actionButton("zm_st_gr", "Zmień status grupy"))
                                      ),
                                      hr(),
                                      tabsetPanel(
                                        # tabela
                                        tabPanel("Grupy", dataTableOutput('grupy_lista', width="80%"))
                                      ))),
            tabItem("ter_zaj_grup", h2("Terminy zajęć grup"),
                            fluidPage(theme = shinytheme("flatly"),
                                      height = '100%',hr(),
                                      fluidRow(
                                        column(3, actionButton("dod_term_zaj_gr", "Dodaj termin zajęć grupy")),
                                        column(3, actionButton("us_term_zaj_gr", "Usuń termin zajęć grupy")),
                                        column(3, actionButton("zak_term_zaj_gr", "Zaktualizuj termin zajęć grupy"))
                                      ),
                                      hr(),
                                      tabsetPanel(
                                        # tabela
                                        tabPanel("Terminy zajeć grup", dataTableOutput('terminy_zajec_grup_lista', width="80%")
                                                 # Przycisk otwierający okno modalne
                                                 #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                        )))),
            tabItem("gr_ucz", h2("Uczniowie i ich grupy"),
                                    fluidPage(theme = shinytheme("flatly"),
                                              height = '100%',hr(),
                                              fluidRow(
                                                column(3, actionButton("formularz_us_ucznia_z_grupy", "Usuń ucznia z grupy"))
                                              ),
                                              hr(),
                                              tabsetPanel(
                                                # tabela
                                                tabPanel("Zajęcia uczniów", dataTableOutput('zajecia_uczniow_lista', width="80%"))
                                              ))),
            tabItem("daty_kursow", h2("Ważne daty dla grup"),
                                    fluidPage(theme = shinytheme("flatly"),
                                              height = '100%',hr(),
                                              fluidRow(
                                                column(3, actionButton("dod_daty_kursu", "Dodaj daty kursu")),
                                                column(3, actionButton("us_daty_kursu", "Usuń daty kursu")),
                                                column(3, actionButton("zak_daty_kursu", "Zaktualizuj daty kursu"))
                                              ),
                                              hr(),
                                              tabsetPanel(
                                                # tabela
                                                tabPanel("Daty kursów", dataTableOutput('daty_kursu_lista', width="80%")
                                                         # Przycisk otwierający okno modalne
                                                         #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                                )))),
            tabItem("st_grup", h2("Aktualne statusy grup"),
                                            fluidPage(theme = shinytheme("flatly"),
                                                      height = '100%',hr(),
                                                      fluidRow(
                                                        column(2, actionButton("dod_status", "Dodaj status")),
                                                        column(2, actionButton("us_status", "Usuń status"))
                                                      ),
                                                      hr(),
                                                      tabsetPanel(
                                                        # tabela
                                                        tabPanel("Statusy grup", dataTableOutput('status_grupy_lista', width="80%"))
                                                      ))),
            tabItem("ter_zaj", h2("Możliwe terminy zajęć"),
                                            fluidPage(theme = shinytheme("flatly"),
                                                      height = '100%',hr(),
                                                      fluidRow(
                                                        column(2, actionButton("dod_termin_zaj", "Dodaj termin")),
                                                        column(2, actionButton("us_termin_zaj", "Usuń termin"))
                                                      ),
                                                      hr(),
                                                      tabsetPanel(
                                                        # tabela
                                                        tabPanel("Terminy zajęć", dataTableOutput('termin_zajec_lista', width="80%")
                                                                 # Przycisk otwierający okno modalne
                                                                 #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                                        )))),
            tabItem("ceny2", h2("Cennik"),
                                                    fluidPage(theme = shinytheme("flatly"),
                                                              height = '100%',hr(),
                                                              fluidRow(
                                                                column(4, actionButton("dod_ceny", "Dodaj nową pozycję do cennika")),
                                                                column(3, actionButton("us_ceny", "Usuń pozycję z cennika")),
                                                                column(3, actionButton("zak_ceny", "Zaktualizuj pozycję z cennika"))
                                                              ),
                                                              hr(),
                                                              tabsetPanel(
                                                                # tabela
                                                                tabPanel("Ceny kursów", dataTableOutput('ceny_lista', width="80%"))
                                                              ))),
            tabItem("lim_miejsc", h2("Możliwe limity miejsc"),
                                                    fluidPage(theme = shinytheme("flatly"),
                                                              height = '100%',hr(),
                                                              fluidRow(
                                                                column(2, actionButton("dod_limit", "Dodaj limit")),
                                                                column(2, actionButton("us_limit", "Usuń limit"))
                                                              ),
                                                              hr(),
                                                              tabsetPanel(
                                                                # tabela
                                                                tabPanel("Limity miejsc", dataTableOutput('limity_lista', width="80%")
                                                                         # Przycisk otwierający okno modalne
                                                                         #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                                                )))),
            tabItem("t_szkol", h2("Typy szkół dla których szkoła oferuje swoje usługi"),
                                                            fluidPage(theme = shinytheme("flatly"),
                                                                      height = '100%',hr(),
                                                                      fluidRow(
                                                                        column(3, actionButton("dod_typ_szkoly", "Dodaj typ szkoły")),
                                                                        column(3, actionButton("us_typ_szkoly", "Usuń typ szkoły"))
                                                                      ),
                                                                      hr(),
                                                                      tabsetPanel(
                                                                        # tabela
                                                                        tabPanel("Typy szkół", dataTableOutput('typ_szkoly_lista', width="80%"))
                                                                      ))),
            tabItem("t_kursow", h2("Oferowane typy kursów"),
                                                            fluidPage(theme = shinytheme("flatly"),
                                                                      height = '100%',hr(),
                                                                      fluidRow(
                                                                        column(3, actionButton("dod_typ_kursu", "Dodaj typ kursu")),
                                                                        column(3, actionButton("us_typ_kursu", "Usuń typ kursu"))
                                                                      ),
                                                                      hr(),
                                                                      tabsetPanel(
                                                                        # tabela
                                                                        tabPanel("Typy kursów", dataTableOutput('typ_kursu_lista', width="80%")
                                                                                 # Przycisk otwierający okno modalne
                                                                                 #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                                                        )))),
              tabItem("poziomy2", h2("Oferowane poziomy kursów"),
                                                                    fluidPage(theme = shinytheme("flatly"),
                                                                              height = '100%',hr(),
                                                                              fluidRow(
                                                                                column(2, actionButton("dod_poziom", "Dodaj poziom")),
                                                                                column(2, actionButton("us_poziom", "Usuń poziom"))
                                                                              ),
                                                                              hr(),
                                                                              tabsetPanel(
                                                                                # tabela
                                                                                tabPanel("Poziomy", dataTableOutput('poziomy_lista', width="80%"))
                                                                              ))),
              tabItem("przedmioty2", h2("Oferowane przedmioty"),
                                                                    fluidPage(theme = shinytheme("flatly"),
                                                                              height = '100%',hr(),
                                                                              fluidRow(
                                                                                column(2, actionButton("dod_przedmiot", "Dodaj przedmiot")),
                                                                                column(2, actionButton("us_przedmiot", "Usuń przedmiot"))
                                                                              ),
                                                                              hr(),
                                                                              tabsetPanel(
                                                                                # tabela
                                                                                tabPanel("Przedmioty", dataTableOutput('przedmioty_lista', width="80%")
                                                                                         # Przycisk otwierający okno modalne
                                                                                         #actionButton("otworz_formularz_wypisu", "Wypisz się z grupy")
                                                                                )))
                    )
            
          )
        }else if(identical(dynamiczne_zakladki,c("Zakładka B", "Zakładka C"))){
          #################################################### NAUCZYCIELE #################################################################################
          tabItems(
            tabItem("strona_glowna", h2("Witamy w serwisie Szkoły Delta"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Nowe grupy",
                                         hr(),
                                         h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Oto grupy, w których zostały jeszcze wolne miejsca:"),
                                         hr(),
                                         dataTableOutput('aktualnie_rekrutujace_grupy_lista', width="80%"))
                              ))),
            tabItem("moj_grafik", h2("Mój grafik"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel(hr(),
                                  h3("Grupy aktywne"),
                                  "Moje aktualne grupy", dataTableOutput('dynamiczny_grafik_nauczyciela_aktualny', width="80%"),
                                         hr(),
                                         h3("Grupy planowane"),
                                "Moje planowane grupy", dataTableOutput('dynamiczny_grafik_nauczyciela_plany', width="80%"))
                              ))),
            tabItem("moi_uczniowie", h2("Moi uczniowie"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Moi uczniowie", dataTableOutput('dynamiczny_spis_uczniow', width="80%"),
                                         # Przycisk regulujący wyświetlanie uczniów z grup
                                         selectInput('id_grupy3', 'Wybierz id grupy, której listę uczniów chcesz zobaczyć.',choices =c(" ",dbGetQuery(con, paste0("SELECT id FROM grupy_nauczyciela(",user_data()$id,")") ))),
                                         actionButton('filtruj_dyn_s_u', "Filtruj")
                                ))))
            
          )
        } else {
          ##################################################### UCZNIOWIE ################################################################################
          
          tabItems(
            tabItem("strona_glowna", h2("Witamy w serwisie Szkoły Delta"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Nowe grupy",
                                         hr(),
                                         h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Oto grupy, w których zostały jeszcze wolne miejsca:"),
                                         hr(),
                                         dataTableOutput('aktualnie_rekrutujace_grupy_lista', width="80%"))
                              ))),
            tabItem("moje_grupy", h2("Moje aktualne grupy"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Moje grupy", dataTableOutput('dynamiczny_grafik_ucznia', width="80%"),
                                         # Przycisk otwierający okno modalne
                                         actionButton("otworz_formularz_wypisu", "Wypisz się z grupy"))
                              ))),
            tabItem("grupy1", h2("Nowe oferowane grupy"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Wszystkie planowane grupy",
                                         hr(),
                                         h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Prowadzimy kursy standardowe i intensywne.
                                         Zajęcia w ramach kursów standardowych odbywają się raz w tygodniu, natomiast zajęcia grup intensywnych
                                           odbywają się dwa razy w tygodniu. Poniżej możesz sprawdzić terminy:"),
                                         hr(),
                                         dataTableOutput('aktualny_grafik_zapisow_lista', width="60%"),
                                         dataTableOutput('zapisy_info_grupy_lista', width = "80%"),
                                         hr(),
                                         # Przycisk otwierający okno modalne
                                         actionButton("otworz_formularz_zapisu", "Zapisz się do grupy"))
                              ))),
            tabItem("przedmioty1", h2("Tabela wszystkich oferowanych przedmiotów"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Wszystkie przedmioty", dataTableOutput('ladne_przedmioty_lista', width="50%"))
                              ))),
            tabItem("poziomy1", h2("Tabela wszystkich oferowanych rodzajów zajęć"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Wszystkie poziomy", dataTableOutput('ladne_poziomy_lista', width="50%"))
                              ))),
            tabItem("typ_kursu1", h2("Tabela wszystkich oferowanych typów kursów"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Wszystkie typy kursów", dataTableOutput('ladne_typy_kursow_lista', width="50%"))
                              ))),
            tabItem("nauczyciele1", h2("Pełna lista kadry nauczycielskiej"),
                    fluidPage(theme = shinytheme("flatly"),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Nauczyciele", dataTableOutput('nauczyciele_lista', width="50%"))
                              ))),
            tabItem("cennik1", h2("Cennik zajęć"),
                    fluidPage(theme = shinytheme("flatly"),
                              tags$head(
                                tags$style(HTML("
                        .nav-tabs > li > a {
                          display: none !important;
                        }
                        .tab-content {
                          margin-top: -15px; # opcjonalne dostosowanie marginesu
                        }
                      "))
                              ),
                              height = '100%',
                              tabsetPanel(
                                # tabela
                                tabPanel("Pełny cennik", dataTableOutput('ladne_ceny_lista', width="50%"))
                              )))
          )
        }
      } else {
        ################################# inny rodzaj uzytkownika ############################################
        
        tabItems(
          tabItem("strona_glowna", h2("Witamy w serwisie Szkoły Delta"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Nowe grupy",
                                       hr(),
                                       h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Oto grupy, w których zostały jeszcze wolne miejsca:"),
                                       hr(),
                                       dataTableOutput('aktualnie_rekrutujace_grupy_lista', width="80%"))
                            ))),
          tabItem("rejestracja", h2("Zarejestruj się"),
                  fluidPage(theme = shinytheme("flatly"), column(12, offset = 4,
                                                                 helpText('W celu rejestracji proszę podać swoje dane.'),
                                                                 textInput('imie', 'Podaj imię', value=''),
                                                                 textInput('nazwisko', 'Podaj nazwisko', value=''),
                                                                 textInput('mail', 'Podaj e-mail', value=''),
                                                                 textInput('login', 'Podaj login', value=''),
                                                                 textInput('haslo', 'Podaj hasło', value=''),
                                                                 selectInput('t_szkoly', 'Wybierz typ szkoły do której uczęszczasz.',choices =c(" ",dbGetQuery(con, "SELECT nazwa FROM typ_szkoly where nazwa!='nie dotyczy'"))),
                                                                 actionButton('zarejestruj', 'Zarejestruj')
                                                                 
                  ))),
          tabItem("grupy1", h2("Nowe oferowane grupy"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Wszystkie planowane grupy", dataTableOutput('aktualny_grafik_zapisow_lista', width="60%"))
                            ))),
          tabItem("przedmioty1", h2("Tabela wszystkich oferowanych przedmiotów"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Wszystkie przedmioty", dataTableOutput('ladne_przedmioty_lista', width="50%"))
                            ))),
          tabItem("poziomy1", h2("Tabela wszystkich oferowanych rodzajów zajęć"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Wszystkie poziomy", dataTableOutput('ladne_poziomy_lista', width="50%"))
                            ))),
          tabItem("typ_kursu1", h2("Tabela wszystkich oferowanych typów kursów"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Wszystkie typy kursów", dataTableOutput('ladne_typy_kursow_lista', width="50%"))
                            ))),
          tabItem("nauczyciele1", h2("Pełna lista kadry nauczycielskiej"),
                  fluidPage(theme = shinytheme("flatly"),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Nauczyciele", dataTableOutput('nauczyciele_lista', width="50%"))
                            ))),
          tabItem("cennik1", h2("Cennik zajęć"),
                  fluidPage(theme = shinytheme("flatly"),
                            tags$head(
                              tags$style(HTML("
                        .nav-tabs > li > a {
                          display: none !important;
                        }
                        .tab-content {
                          margin-top: -15px; # opcjonalne dostosowanie marginesu
                        }
                      "))
                            ),
                            height = '100%',
                            tabsetPanel(
                              # tabela
                              tabPanel("Pełny cennik", dataTableOutput('ladne_ceny_lista', width="50%"))
                            )))
        )
      }
    } else {
      ############################### PRZED ZALOGOWANIEM #####################################################################################
      # Wyświetl zawartość strony głównej, gdy użytkownik nie jest zalogowany
      
      tabItems(
        tabItem("strona_glowna", h2("Witamy w serwisie Szkoły Delta"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Nowe grupy",
                                     hr(),
                                     h4("Zapraszamy do skorzystania z oferty edukacyjnej naszej szkoły. Oto grupy, w których zostały jeszcze wolne miejsca:"),
                                     hr(),
                                     dataTableOutput('aktualnie_rekrutujace_grupy_lista', width="80%"),
                                     hr(), h4("O nas"),
                                     p("Nasza szkoła od lat specjalizuje się w przygotowaniu uczniów do 
      egzaminów podsumowujących poszczególne etapy edukacji. Współpracujemy z osobami pełnymi
      pasji do nauczania - prawdziwymi erudytami, którzy cenią interdyscyplinarne podejście do 
      zagadnień egzaminacyjnych i pozostają otwarci na indywidualne potrzeby uczniów. Naszą misją 
      jest skuteczne edukowanie w przyjaznej atmosferze. Dołącz do nas już dziś - gwarantujemy, że 
      nauka do egzaminu zmieni się w fascynującą intelektualną przygodę!"))
                          ))),
        tabItem("rejestracja", h2("Zarejestruj się"),
                fluidPage(theme = shinytheme("flatly"), column(12, offset = 4,
                                                               helpText('W celu rejestracji proszę podać swoje dane.'),
                                                               textInput('imie', 'Podaj imię', value=''),
                                                               textInput('nazwisko', 'Podaj nazwisko', value=''),
                                                               textInput('mail', 'Podaj e-mail', value=''),
                                                               textInput('login', 'Podaj login', value=''),
                                                               textInput('haslo', 'Podaj hasło', value=''),
                                                               selectInput('t_szkoly', 'Wybierz typ szkoły do której uczęszczasz.',choices =c(" ",dbGetQuery(con, "SELECT nazwa FROM typ_szkoly where nazwa!='nie dotyczy'"))),
                                                               actionButton('zarejestruj', 'Zarejestruj')
                                                               
                ))),
        tabItem("grupy1", h2("Nowe oferowane grupy"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Wszystkie planowane grupy", dataTableOutput('aktualny_grafik_zapisow_lista', width="60%"))
                          ))),
        tabItem("przedmioty1", h2("Tabela wszystkich oferowanych przedmiotów"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Wszystkie przedmioty", dataTableOutput('ladne_przedmioty_lista', width="50%"))
                          ))),
        tabItem("poziomy1", h2("Tabela wszystkich oferowanych rodzajów zajęć"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Wszystkie poziomy", dataTableOutput('ladne_poziomy_lista', width="50%"))
                          ))),
        tabItem("typ_kursu1", h2("Tabela wszystkich oferowanych typów kursów"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Wszystkie typy kursów", dataTableOutput('ladne_typy_kursow_lista', width="50%"))
                          ))),
        tabItem("nauczyciele1", h2("Pełna lista kadry nauczycielskiej"),
                fluidPage(theme = shinytheme("flatly"),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Nauczyciele", dataTableOutput('nauczyciele_lista', width="50%"))
                          ))),
        tabItem("cennik1", h2("Cennik zajęć"),
                fluidPage(theme = shinytheme("flatly"),
                          tags$head(
                            tags$style(HTML("
                        .nav-tabs > li > a {
                          display: none !important;
                        }
                        .tab-content {
                          margin-top: -15px; # opcjonalne dostosowanie marginesu
                        }
                      "))
                          ),
                          height = '100%',
                          tabsetPanel(
                            # tabela
                            tabPanel("Pełny cennik", dataTableOutput('ladne_ceny_lista', width="50%"))
                          )))
      )
    }
  })
  
  # Obsługa zamknięcia okna interfejsu przy błędach
  observe({
    if (!is.null(input$shinyalert)) {
      if (input$shinyalert == 'shinyalert') {
        shinyjs::runjs("window.onbeforeunload = null;")
      }
    }
  })
  
  # Obserwator do wyczyszczenia pola hasła
  observe({
    if (password_clear()) {
      updateTextInput(session, "password", value = "")
      password_clear(FALSE)  # Resetujemy zmienną po wyczyszczeniu
    }
  })
  
  # Obserwator dla przycisku "Wyczyść hasło"
  observeEvent(input$clearButton, {
    password_clear(TRUE)
  })

  
  observeEvent(input$zarejestruj, {
    
    # sprawdzenie poprawności danych
    imie <- isolate(input$imie)
    nazwisko <- isolate(input$nazwisko)
    mail <- isolate(input$mail)
    login <- isolate(input$login)
    haslo <- isolate(input$haslo)
    t_s <- isolate(input$t_szkoly)
    
    if(imie==""){
      showNotification("Pole z imieniem nie może być puste!", type = "error")
    } else if(nazwisko==""){
      showNotification("Pole z nazwiskiem nie może być puste!", type = "error")
    } else if(mail==""){
      showNotification("Pole z e-mailem nie może być puste!", type = "error")
    } else if(login==""){  # Poprawka: dodano warunek na puste pole loginu
      showNotification("Pole z loginem nie może być puste!", type = "error")
    } else if(haslo==""){
      showNotification("Pole z hasłem nie może być puste!", type = "error")
    } else if(is.null(t_s)){
      showNotification("Musisz wybrać typ szkoły!", type = "error")
    } else {
      res <- dbSendStatement(con, paste0("select dodaj_uzytkownika(","'",input$login,"'", ",", "'",
                                         input$haslo,"'", ",","3",",", "'",
                                         input$imie, "'", ",", "'",
                                         input$nazwisko, "'",",","'",
                                         input$mail,"'",",",
                                         typ_szkoly$id[which(typ_szkoly$nazwa==input$t_szkoly)], ")"))
      data <- dbFetch(res)
      shinyalert(print(data[1,1]), type = "info")
    }
    
    updateTextInput(session, 'mail', value='')
    updateTextInput(session, 'haslo', value='')
    updateTextInput(session, 'imie', value='')
    updateTextInput(session, 'nazwisko', value='')
    updateTextInput(session, 'login', value='')
    updateSelectInput(session, 't_szkoly', label = NULL, choices =c(" ",dbGetQuery(con, "SELECT nazwa FROM typ_szkoly where nazwa!='nie dotyczy'")), selected = NULL)
    output$typ_szkoly_lista <- renderDataTable( dbGetQuery(con, "SELECT id, nazwa FROM typ_szkoly order by 1"))
    output$uzytkownicy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uzytkownicy"))
    output$uczniowie_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uczniowie"))
  })
  
  
  
  # Obsługa logowania
  observeEvent(input$login_button, {
    # Przykładowe dane, do zastąpienia danymi z bazy
    user <- isolate(input$username)
    password <- isolate(input$password)
    
    # Sprawdzenie poprawności danych
    if (validate_user(user, password)) {
      if (is.null(user_data())) {
        user_data(uzytkownicy[uzytkownicy$login == user, ])
        showNotification("Zostałeś poprawnie zalogowany!", type = "message")
      } else {
        showNotification("Jesteś już zalogowany, jeśli chcesz się zalogować ponownie, najpierw wyloguj się!", type = "warning")
      }
    } else {
      showNotification("Nieprawidłowy użytkownik lub hasło.", type = "error")
    }
    updateTextInput(session, 'username', value="")
  })
  
  
  # Obsługa wylogowywania
  observeEvent(input$logout_button, {
    user_data(NULL)
    showNotification("Zostałeś poprawnie wylogowany!", type = "message")
  })
  
  # Funkcja walidująca użytkownika
  validate_user <- function(user, password) {
    valid_user <- uzytkownicy[uzytkownicy$login == user, ]
    
    if (nrow(valid_user) == 1) {
      return(valid_user$haslo == password)
    } else {
      return(FALSE)
    }
  }
  
  ###############
  observeEvent(input$filtruj_dyn_s_u, {
    id_grupy <- isolate(input$id_grupy3)
    if (is.null(id_grupy)) {
      showNotification("Musisz wybrać id grupy!", type = "error")
    } else {
      # Aktualizacja dynamicznego spisu uczniow
      output$dynamiczny_spis_uczniow <- renderDataTable({
        req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
        
        # Pobieramy dane dla zalogowanego użytkownika
        data <- dbGetQuery(con, paste0("SELECT * from uczniowie_w_grupie(", user_data()$id, ",",input$id_grupy3,")"))
        
        # Renderujemy DataTable
        datatable(data, options = list(
          paging = TRUE,  # Paginacja
          searching = TRUE,  # Wyszukiwanie
          ordering = TRUE,  # Sortowanie
          lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
          pageLength = 10,  # Domyślna liczba rekordów na stronie
          dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
          buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
        ))
      })
    }
  })
  
  #############
  observeEvent(input$otworz_formularz_wypisu, {
    showModal(
      modalDialog(
        title = "Formularz wypisu z grupy",
        selectInput('id_grupy1', 'Wybierz id grupy, z której chcesz się wypisać.', choices = c(" ", dbGetQuery(con, paste0("SELECT id_g FROM zajecia_ucznia(",user_data()$id,")")))),
        actionButton('wypisz_sie', 'Wypisz się'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$wypisz_sie, {
    id_grupy <- isolate(input$id_grupy1)
    
    if (is.null(id_grupy)) {
      showNotification("Musisz wybrać id grupy!", type = "error")
    } else {
      res <- dbSendStatement(con, paste0("select wypisz_ucznia(", user_data()$id, ",", input$id_grupy1, ")"))
      data <- dbFetch(res)
      shinyalert(print(data[1,1]), type = "info")
    }
    
    # Aktualizacja listy grup
    updateSelectInput(session, 'id_grupy1', label = NULL, choices = c(" ", dbGetQuery(con, paste0("SELECT id_g FROM zajecia_ucznia(",user_data()$id,")"))), selected = NULL)
    
    # Aktualizacja tabeli zajęć uczniów
    output$zajecia_uczniow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM zajecia_uczniow"))
    
    # Aktualizacja dynamicznego grafiku ucznia
    output$dynamiczny_grafik_ucznia <- renderDataTable({
      req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
      
      # Pobieramy dane dla zalogowanego użytkownika
      data <- dbGetQuery(con, paste0("SELECT * from zajecia_ucznia(", user_data()$id, ")"))
      
      # Renderujemy DataTable
      datatable(data, options = list(
        paging = TRUE,  # Paginacja
        searching = TRUE,  # Wyszukiwanie
        ordering = TRUE,  # Sortowanie
        lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
        pageLength = 10,  # Domyślna liczba rekordów na stronie
        dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
      ))
    })
  })
  
  
  #############
  observeEvent(input$otworz_formularz_zapisu, {
    showModal(
      modalDialog(
        title = "Formularz zapisu do grupy",
        selectInput('id_grupy', 'Wybierz id grupy do której chcesz się zapisać.', choices = c(" ", dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id"))),
        actionButton('zapisz_sie', 'Zapisz się'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zapisz_sie, {
    id_grupy <- isolate(input$id_grupy)
    
    if (is.null(id_grupy)) {
      showNotification("Musisz wybrać id grupy!", type = "error")
    } else {
      tryCatch({
        query <- paste0("select zapisz_sie_do_grupy(", user_data()$id, ",", input$id_grupy, ")")
        data <- dbGetQuery(con, query)
        
        if (data[1, 1] == "SUKCES") {
          #showNotification("Zapisano do grupy!", type = "success")
          shinyalert(print(data[1, 1]), type = "info")
        } else {
          # W przypadku błędu, aktualizuj zawartość statusu wewnątrz modalu
          #output$status <- renderText(paste0("Uwaga: ", data[1, 1]))
          shinyalert(print(data[1, 1]), type = "info")
        }
      }, error = function(e) {
        # W przypadku błędu, komunikat o błędzie
        showNotification(paste("Błąd:", "nie możesz się zapisać na zajęcia, które nie odpowiadają typowi twojej szkoły!"), type = "error")
      })
    }
    
    # Aktualizacja listy grup
    updateSelectInput(session, 'id_grupy', label = NULL, choices = c(" ", dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id")), selected = NULL)
    
    # Aktualizacja tabeli zajęć uczniów
    output$zajecia_uczniow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM zajecia_uczniow"))
    
    # Aktualizacja dynamicznego grafiku ucznia
    output$dynamiczny_grafik_ucznia <- renderDataTable({
      req(user_data())  # Sprawdzamy, czy użytkownik jest zalogowany
      
      # Pobieramy dane dla zalogowanego użytkownika
      data <- dbGetQuery(con, paste0("SELECT * from zajecia_ucznia(", user_data()$id, ")"))
      
      # Renderujemy DataTable
      datatable(data, options = list(
        paging = TRUE,  # Paginacja
        searching = TRUE,  # Wyszukiwanie
        ordering = TRUE,  # Sortowanie
        lengthMenu = c(10, 25, 50),  # Liczba rekordów na stronie
        pageLength = 10,  # Domyślna liczba rekordów na stronie
        dom = 'Bfrtip',  # Ustawienia dodatkowe dla DataTables i Buttons
        buttons = c('copy', 'csv', 'excel', 'pdf', 'print')
      ))
    })
  })
  
  
  ################# przyciski admina ####################
  
  #############
  observeEvent(input$formularz_us_ucznia_z_grupy, {
    showModal(
      modalDialog(
        title = "Formularz usunięcia ucznia z grupy",
        textInput('id_ucznia', 'Podaj id ucznia którego chcesz wypisać z grupy.'),
        textInput('id_grupy', 'Podaj id grupy z której chcesz wypisać ucznia.'),
        actionButton('zatwierdz1', 'Zatwierdź'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz1, {
    id_ucznia <- isolate(input$id_ucznia)
    id_grupy <- isolate(input$id_grupy)
    
    if (is.null(id_grupy)) {
      showNotification("Musisz wpisać id grupy!", type = "error")
    } else if(is.null(id_ucznia)){
      showNotification("Musisz wpisać id ucznia!", type = "error")
    } else {
        res <- dbSendStatement(con,paste0("select wypisz_ucznia(", input$id_ucznia, ",", input$id_grupy, ")"))
  
        data <- dbFetch(res)
        shinyalert(print(data[1,1]), type = "info")
    }
    
    # Aktualizacja listy grup
    updateTextInput(session, 'id_ucznia', value='')
    updateTextInput(session, 'id_grupy', value='')
    
    # Aktualizacja tabeli zajęć uczniów
    output$zajecia_uczniow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM zajecia_uczniow"))
    output$id_rek_grup_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id"))
    output$aktualny_grafik_zapisow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualny_grafik_zapisow"))
    output$aktualnie_rekrutujace_grupy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy"))
    
  })
  
  
  #############
  observeEvent(input$formularz_dod_nauczyciela, {
    showModal(
      modalDialog(
        title = "Formularz dodania nowego nauczyciela",
        textInput('imie', 'Podaj imię.'),
        textInput('nazwisko', 'Podaj nazwisko.'),
        textInput('login', 'Podaj login.'),
        textInput('haslo', 'Podaj hasło.'),
        textInput('mail', 'Podaj adres e-mail.'),
        actionButton('zatwierdz2', 'Zatwierdź'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz2, {
    imie <- isolate(input$imie)
    nazwisko <- isolate(input$nazwisko)
    mail <- isolate(input$mail)
    login <- isolate(input$login)
    haslo <- isolate(input$haslo)
    
    if(imie==""){
      showNotification("Pole z imieniem nie może być puste!", type = "error")
    } else if(nazwisko==""){
      showNotification("Pole z nazwiskiem nie może być puste!", type = "error")
    } else if(mail==""){
      showNotification("Pole z e-mailem nie może być puste!", type = "error")
    } else if(login==""){  # Poprawka: dodano warunek na puste pole loginu
      showNotification("Pole z loginem nie może być puste!", type = "error")
    } else if(haslo==""){
      showNotification("Pole z hasłem nie może być puste!", type = "error")
    } else {
      res <- dbSendStatement(con, paste0("select dodaj_uzytkownika(","'",input$login,"'", ",", "'",
                                         input$haslo,"'", ",","2",",", "'",
                                         input$imie, "'", ",", "'",
                                         input$nazwisko, "'",",","'",
                                         input$mail,"'",",",
                                         typ_szkoly$id[which(typ_szkoly$nazwa=='nie dotyczy')],")"))
      data <- dbFetch(res)
      shinyalert(print(data[1,1]), type = "info")
    }
    
    updateTextInput(session, 'mail', value='')
    updateTextInput(session, 'haslo', value='')
    updateTextInput(session, 'imie', value='')
    updateTextInput(session, 'nazwisko', value='')
    updateTextInput(session, 'login', value='')
    
    output$uzytkownicy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uzytkownicy"))
    output$nauczyciele_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM nauczyciele"))
    
    
  })
  
  
  #############
  observeEvent(input$formularz_us_nauczyciela, {
    showModal(
      modalDialog(
        title = "Formularz zwalniający nauczyciela",
        textInput('id_nauczyciela', 'Podaj id nauczyciela, którego chcesz zwolnić.'),
        actionButton('zatwierdz3', 'Zatwierdź'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz3, {
    id_nauczyciela <- isolate(input$id_nauczyciela)
    
    if (is.null(id_nauczyciela)) {
      showNotification("Musisz wpisać id nauczyciela!", type = "error")
    } else {
        res <- dbSendStatement(con,paste0("select zwolnij_nauczyciela(", input$id_nauczyciela, ")"))
        
        data <- dbFetch(res)
        shinyalert(print(data[1,1]), type = "info")
    }
    
    # Aktualizacja listy grup
    updateTextInput(session, 'id_nauczyciela', value='')
    
    # Aktualizacja tabeli zajęć uczniów
    output$uzytkownicy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uzytkownicy"))
    output$nauczyciele_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM nauczyciele"))
    output$grupy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM grupy"))
    output$zapisy_info_grupy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM zapisy_dalsze_info"))
    output$id_rek_grup_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id"))
    output$aktualnie_uczacy_nauczyciele_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_uczacy_nauczyciele"))
    output$aktualny_grafik_grup_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualny_grafik_grup"))
    output$aktualny_grafik_zapisow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualny_grafik_zapisow"))
    output$aktualnie_rekrutujace_grupy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy"))
    
  })
  
  
  
  #############
  observeEvent(input$formularz_us_ucznia, {
    showModal(
      modalDialog(
        title = "Formularz usuwający ucznia",
        textInput('id_ucznia', 'Podaj id ucznia, którego chcesz usunąć.'),
        actionButton('zatwierdz4', 'Zatwierdź'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz4, {
    id_ucznia <- isolate(input$id_ucznia)
    
    if (is.null(id_ucznia)) {
      showNotification("Musisz wpisać id ucznia!", type = "error")
    } else {
        res <- dbSendStatement(con,paste0("select usun_ucznia(", input$id_ucznia, ")"))
        
        data <- dbFetch(res)
        shinyalert(print(data[1,1]), type = "info")
    }
    
    # Aktualizacja listy grup
    updateTextInput(session, 'id_ucznia', value='')
    
    # Aktualizacja tabeli zajęć uczniów
    output$uzytkownicy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uzytkownicy"))
    output$uczniowie_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM uczniowie"))
    output$zajecia_uczniow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM zajecia_uczniow"))
    output$id_rek_grup_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy_id"))
    output$aktualny_grafik_zapisow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualny_grafik_zapisow"))
    output$aktualnie_rekrutujace_grupy_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM aktualnie_rekrutujace_grupy"))
    refresh()
    
  })
  
  
  #############
  observeEvent(input$formularz_us_r_uzyt, {
    showModal(
      modalDialog(
        title = "Formularz usunięcia rodzaju użytkownika",
        textInput('nazwa', 'Podaj nazwę rodzaju użytkownika, którego chcesz usunąć.'),
        actionButton('zatwierdz5', 'Usuń'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz5, {
    nazwa <- isolate(input$nazwa)
    
    if (is.null(nazwa)) {
      showNotification("Musisz wpisać nazwę rodzaju użytkownika!", type = "error")
    } else {
        res <- dbSendStatement(con,paste0("select usun_rodzaj_uzytkownika(","'", input$nazwa, "')"))
        
        data <- dbFetch(res)
        shinyalert(print(data[1,1]), type = "info")
      
    }
    
    # Aktualizacja listy grup
    updateTextInput(session, 'nazwa', value='')
    
    # Aktualizacja tabeli zajęć uczniów
    output$rodzaje_uzytkownikow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM rodzaje_uzytkownikow"))
    refresh()
    
  })
  
  ###########
  observeEvent(input$formularz_dod_rodz_uzyt, {
    showModal(
      modalDialog(
        title = "Formularz dodania rodzaju użytkownika",
        textInput('nazwa', 'Podaj nazwę rodzaju użytkownika, którego chcesz dodać.'),
        actionButton('zatwierdz6', 'Dodaj'),
        easyClose = TRUE  # Działa jako przycisk "Zamknij" na górnym pasku modalu
      )
    )
  })
  
  
  observeEvent(input$zatwierdz6, {
    nazwa <- isolate(input$nazwa)
    
    if(nazwa==""){
      showNotification("Pole z nazwą nie może być puste!", type = "error")
    } else {
      res <- dbSendStatement(con, paste0("select dodaj_rodzaj_uzytkownika(","'",input$nazwa,"'",")"))
      data <- dbFetch(res)
      shinyalert(print(data[1,1]), type = "info")
    }
    
    updateTextInput(session, 'nazwa', value='')
    
    # Aktualizacja tabeli zajęć uczniów
    output$rodzaje_uzytkownikow_lista = renderDataTable(dbGetQuery(con, "SELECT * FROM rodzaje_uzytkownikow"))
    refresh()
    
    
  })
  

  #############
  
  # Pobranie dynamicznych zakładek z bazy (to przykładowa funkcja, dostosuj ją do swoich potrzeb)
  get_dynamic_tabs <- function(stopien_dostepu) {
    # Tu powinno być zapytanie do bazy i pobranie zakładek dla danego stopnia dostępu
    # Przykładowe dane
    if (stopien_dostepu == 1) {
      return(c("Zakładka A", "Zakładka B"))
    } else if (stopien_dostepu == 2) {
      return(c("Zakładka B", "Zakładka C"))
    } else if (stopien_dostepu == 3) {
      return(c("Zakładka A", "Zakładka C"))
    } else {
      return(character(0))
    }
  }
}

shinyApp(ui, server)
