select*
from portfolio_project.covid_deaths
where continent is not null;


select location,date,total_cases,new_cases,total_deaths,population
from portfolio_project.covid_deaths
where continent is not null;



-- shows death percentage

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from portfolio_project.covid_deaths
where location like '%india%'
and continent is not null;



-- shows percentage of population affected by covid

select location,date,population,total_cases,(total_cases/population)*100 as population_affected_percentage
from portfolio_project.covid_deaths
where location like '%india%'
and continent is not null;



-- countries with hightest infection rate compared to population

select location,population,max(total_cases) as hightest_infection_count,(max(total_cases/population))*100 as population_affected_percentage
from portfolio_project.covid_deaths
where continent is not null
group by population,location
order by population_affected_percentage desc;


-- countries with hightest death count per population have a error!!!

select location, max(total_deaths)as total_death_count
from portfolio_project.covid_deaths
where continent is not null
group by location
order by total_death_count desc;



-- by continent have error!!!
-- continents with highest death count per population

select continent,max(total_deaths) as total_death_count
from portfolio_project.covid_deaths
where continent is not null
group by continent
order by total_death_count desc;



-- goble numbers

select sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,sum(new_deaths)/sum(new_cases)*100 as death_percentage  
from portfolio_project.covid_deaths
-- where location like '%india%'
where continent is not null;
-- group by date;



-- looking at total population vs vaccination have error!!

select covid_deaths.continent,covid_deaths.location,covid_deaths.date,covid_deaths.population,covid_deaths.new_vaccinations,
sum(covid_vaccinations.new_vaccinations) over (partition by covid_deaths.location order by covid_deaths.location,covid_deaths.date) as rolling_people_vaccinated
from portfolio_project.covid_deaths
join portfolio_project.covid_vaccinations 
    on covid_deaths.location = covid_vaccinations.location
    and covid_deaths.date = covid_vaccinations.date
where covid_deaths.continent is not null    



-- use CTE

with popvsvac (continent,location,date,population,new_vacination,rolling_people_vaccinated)
as
(
select covid_deaths.continent,covid_deaths.location,covid_deaths.date,covid_deaths.population,covid_deaths.new_vaccinations,
sum(covid_vaccinations.new_vaccinations) over (partition by covid_deaths.location order by covid_deaths.location,covid_deaths.date) as rolling_people_vaccinated
from portfolio_project.covid_deaths
join portfolio_project.covid_vaccinations 
    on covid_deaths.location = covid_vaccinations.location
    and covid_deaths.date = covid_vaccinations.date
where covid_deaths.continent is not null 
)
select*, (rolling_people_vaccinated/population)*100
from popvac;




-- temp table have error!!!

drop table if exists #percentage_population_vaccinated
create table #percentage_population_vaccinated 
(
continent nvarchar(225),
location nvarchar(225),
date date_time,
population numeric,
rolling_people_vaccinated numeric
)
insert into #percentage_population_vaccinated
select covid_deaths.continent,covid_deaths.location,covid_deaths.date,covid_deaths.population,covid_deaths.new_vaccinations,
sum(covid_vaccinations.new_vaccinations) over (partition by covid_deaths.location order by covid_deaths.location,covid_deaths.date) as rolling_people_vaccinated
from portfolio_project.covid_deaths
join portfolio_project.covid_vaccinations 
    on covid_deaths.location = covid_vaccinations.location
    and covid_deaths.date = covid_vaccinations.date
-- where covid_deaths.continent is not null 

select *, (rolling_people_vaccinated/population)*100
from #percentage_population_vaccinated



-- creating view to store data for later visulaization have error!!

create view percentage_population_vaccinated as 
insert into #percentage_population_vaccinated
select covid_deaths.continent,covid_deaths.location,covid_deaths.date,covid_deaths.population,covid_deaths.new_vaccinations,
sum(covid_vaccinations.new_vaccinations) over (partition by covid_deaths.location order by covid_deaths.location,covid_deaths.date) as rolling_people_vaccinated
from portfolio_project.covid_deaths
join portfolio_project.covid_vaccinations 
    on covid_deaths.location = covid_vaccinations.location
    and covid_deaths.date = covid_vaccinations.date
where covid_deaths.continent is not null;



-- additional code 

select location,population,date,max(total_cases) as hightest_infection_count,(max(total_cases/population))*100 as population_affected_percentage
from portfolio_project.covid_deaths
-- where continent is not null
group by population,location,date
order by population_affected_percentage desc;