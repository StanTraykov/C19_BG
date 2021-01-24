# c19bg

Пакет за генериране на COVID-19 графики от отворените данни на България, EUROSTAT, ECDC, НСИ.

* Графиките са тук: https://stantraykov.github.io/c19bg/
* [Документация на публичните функции в пакета](https://stantraykov.github.io/c19bg/docs/reference/index.html)
* [Методика за изчисление на R](https://github.com/StanTraykov/C19_BG/wiki/%D0%9C%D0%B5%D1%82%D0%BE%D0%B4%D0%B8%D0%BA%D0%B0-%D0%B7%D0%B0-%D0%B8%D0%B7%D1%87%D0%B8%D1%81%D0%BB%D0%B5%D0%BD%D0%B8%D0%B5-%D0%BD%D0%B0-R)

## Ако сте един от тях...

Ако работите за държавата и имате нещо общо с обработката и публикацията на COVID-19 данни, изпълнете гражданския си дълг и станете [whistleblower](https://bg.wikipedia.org/wiki/%D0%A0%D0%B0%D0%B7%D0%BE%D0%B1%D0%BB%D0%B8%D1%87%D0%B8%D1%82%D0%B5%D0%BB). Разяснете на обществото как се взимат решенията да се скриват елементарни показатели (напр. географска и възрастова разбивка на смъртните случаи, но и много други).

## Инсталация

За инсталация директно от *GitHub*, въведете в [R](https://www.r-project.org/) или (още по-добре) в [RStudio](https://rstudio.com/):

```R
install.packages("remotes")
remotes::install_github("StanTraykov/c19bg")
```
Ако има проблеми с текущата версия, може да [изтеглите рилийз](https://github.com/StanTraykov/c19bg/releases) и инсталирате, напр. `install.packages("../Downloads/c19bg_0.1.0.zip")`.

### Опционално: extrafont

Еднократно и незадължително. Позволява ползването на шрифтове при извеждането на екран и записването в растерни формати (PNG, JPEG). **Не влияе** на векторния SVG изход (вкл. по-нататъшна обработка с външни програми). Единствената засегната графика, при генериране на всички графики с параметри по подразбиране, е хийтмапът на заболеваемостта.

```R
install.packages("extrafont")
extrafont::font_import() # отнема време
```

## Генериране на всички графики

```R
library(c19bg)

# бързо генериране на SVG (високо качество)
# - отиват в c19bg/plots в текущата папка (обикн. Documents под Windows)
# - в c19bg/data ще намерите изтеглените данни и изчислен R (estR.csv)
c19_save_all()

# бързо генериране на PNG, без презареждане от Интернет (dl = F)
c19_save_all(file_ext = ".png", dl = F)

# JPEG
c19_save_all(file_ext =".jpg", dpi = 125, quality = 100)

# PNG 2000x2000px
c19_save_all(file_ext = ".png", dpi = 200, w = 10, h = 10)

# растеризация с Inkscape, JPEG компресия с ImageMagick
# - по-високо качество на PNG и JPEG, но по-бавно
# - вижте раздел Опции за указване на пътища към програмите
c19_inkmagick()  # генерира SVG, PNG и JPEG файлове
# или
c19_inkmagick(dl = F)  # без презареждане от Интернет

# вкл. графики за умирания в други страни (ЕС+)
c19_inkmagick(d_all = TRUE)
```

Пакетът ще се свърже с data.egov.bg, ECDC, EUROSTAT, за да вземе необходимите данни. Данните и графиките ще се запишат в подпапка `c19bg` на текущата (обикновено `Documents` при отваряне на R под Windows). За да използвате записаните данни (`c19bg/data`) без повторно сваляне от Интернет, добавете параметър `dl = F` на функциите за запис на всички графики (вж. примерите).

*Забележка: Изчисляването на репродуктивното число R трае няколко минути, може и над 10 на по-стари компютри. Резултатите се запазват (вкл. при затваряне на R) до промяна в изходните данни.*

## Опции

Опциите могат да се зададат директно в R конзолата или в [.Rprofile или сроден файл](https://support.rstudio.com/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf) за автоматично изпълнение при стартиране на R.

```R
# промяна на шрифт
options(c19bg.font_family = "Calibri")
options(c19bg.font_scale = 1) # скалиране на всички текстове (напр. 0.8, 1.1)
options(c19bg.font_size = 14) # базов размер (пробвайте първо font_scale)
# Забележка: за промяна на размер/резолюция, използвайте аргумент dpi
# във функциите за изход.

options(c19bg.output_dir = "c19bg/plots") # ще бъдат създадени, ако ги няма
options(c19bg.data_dir = "c19bg/data")

options(c19bg.output = list(
    inkopts = "-w %d --export-filename",
    mgkopts = "-quality 100",
    pixwidth = 1375,
    width = 11,
    height = 7,
    inkscape = "\"C:\\Program Files\\Inkscape\\bin\\inkscape.exe\"",
    magick = "magick"  # работи, ако е в PATH
))

# изобразяване на всички опции за пакета
library(c19bg) # предварително зададени опции ще се запазят
names(options())[grep("c19bg",names(options()))]
```

## Генериране на единични графики

```R
library(c19bg)

# зареждане на шрифтове за екран/растерен запис (ако са инсталирани)
if (.Platform$OS.type == "windows" &&
        "extrafont" %in% rownames(installed.packages())) {
    extrafont::loadfonts(device = "win")
}

# слчуаи по възрастови групи
my_plot <- c19_var_plot("age",
                        roll_func = mean,
                        roll_window = 7,
                        line_legend = "0")

# 14-дневно плаващо средно за Европа, Америка с
# изпъкване на Германия
my_plot2 <-c19_eu_weekly("r14_cases",
                         continents = c("Europe", "America"),
                         lower_y = 0,
                         highlight = "DE")

# извеждане на екран
my_plot # или print(my_plot) в неинтерактивен режим
my_plot2
c19_oblasts(incid_100k = TRUE) # извеждане директно на екран

# запис във файл
ggplot2::ggsave(file = "my_plot.png", width = 11, height = 7, plot = my_plot)

# R-графика на екран
# (отнема време, освен ако R вече не е изчислен)
c19_r_plot()

# за разлика от функциите за масово записване, които по подразбиране теглят
# от Интернет, презареждането трябва да се указва ръчно:
c19_reload() # презареждане от диск (c19bg/data)
c19_reload(redownload = TRUE) # презареждане от Интернет

# помощ
?c19_var_plot
?c19_eu_weekly #etc
```
*[Документация на публичните функции в пакета](https://stantraykov.github.io/c19bg/docs/reference/index.html)*

## Данни
```R
library(c19bg)

# Данните могат да се достъпят с тези две функции
# (те се използват и от графичните фукнции)
eu_data <- c19_eu_data()
bg_data <- c19_bg_data()

# При първо изпълнение, те свалят и обработват данни от
# data.egov.bg, ECDC, и EUROSTAT. Това трае известно време.
# Последващи повиквания връщат вече заредените данни. За
# презареждане, напр.:
new_bg_data <- c19_bg_data(reload = TRUE) # от диск
new_eu_data <- c19_eu_data(redownload = TRUE) # от Интернет

# Съдържанието може да се разглежда/задълбава в браузера
# на данни на RStudio.

# ECDC/EUROSTAT седмични случаи, смъртни случаи от COVID-19,
# свръхсмъртност, фактори на надвишаване, брой хоспитализирани,
# тестове, позитивност
View(eu_data$factor_tab)

# Умирания по седмици от EUROSTAT
View(eu_data$eurostat_deaths)

# За България
View(bg_data$gen_inc_hist) # обща статистика, вкл. ограничен набор
                           # данни от преди да отворят данните
View(bg_data$age)          # по възраст (днвени)
View(bg_data$subdivs)      # по области (дневни)
```

### Примерна заявка и графика

Плаващо средно 7 дни по области.

```R
library(dplyr)
library(tidyr)
library(ggplot2)
library(c19bg)

bg_data <- c19_bg_data()
oblasts_table <- bg_data$subdivs %>%
    select(!ends_with("_ACT")) %>%
    pivot_longer(cols = !matches("date"),
                 names_to = "oblast",
                 names_pattern = "(.*)_ALL",
                 values_to = "cases") %>%
    group_by(oblast) %>%
    mutate(mva7 = zoo::rollapply(cases,
                                 7,
                                 mean,
                                 align = "right",
                                 fill = NA))

# графика
my_plot <- ggplot(data = oblasts_table,
                  mapping = aes(x = date, y = mva7, color = oblast)) +
    geom_line()
    
my_plot # изобразяване на екран
ggsave(file = "my_plot.svg", plot = my_plot, width = 13, height = 8)
```

