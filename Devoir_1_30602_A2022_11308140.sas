*Nom: Alla Iakymenko;
*Matricule: 11308140;

/*
------------------------------------------------
------------    DEVOIR 1 -----------------------
------------------------------------------------
*/

/* QUESTION 1 */

*Q1.1;

PROC IMPORT DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\games_2018.csv"
	DBMS= csv REPLACE
	OUT= games;
RUN;


PROC IMPORT DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\box_scores_2018.csv"
	DBMS= csv REPLACE
	OUT= box_scores;
RUN;


PROC IMPORT DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\players_2018.csv"
	DBMS= csv REPLACE
	OUT= players;
RUN;


PROC IMPORT OUT= shot_chart
	DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\shot_chart_2018.csv"
	DBMS= csv REPLACE;
RUN;


PROC IMPORT OUT= ranking
	DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\ranking_2018.csv"
	DBMS= csv REPLACE;
RUN;


PROC IMPORT OUT= teams
	DATAFILE= "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\datasets 2\teams_2018.csv"
	DBMS= csv REPLACE;
RUN;


Proc datasets lib=work;
run;

*Q1.2.a;
proc sql;
	select count(distinct player_name)
		From players;
Quit;

/*Reponse Q1.2.a: 627 de joueurs différents se sont inscrits
dans la ligue lors de la saison 2018-2019.*/


*Q1.2.b;

proc sql;
	select count (distinct player_name)
		From shot_chart;
Quit;

/*Reponse Q1.2.b.: 526 de joueurs différents ont participé 
dans la ligue lors de la saison 2018-2019.*/

*Q1.3;
Proc sql;
	CREATE TABLE bench_players as
		SELECT distinct player_id_bench, player_name
			from
				(Select A.player_name,
					A.PLAYER_id as player_id_bench, 
					B.PLAYER_id AS player_id_particip
				From players as A
					left join shot_chart as B
						on A.PLAYER_id=B.PLAYER_id)
					Where  player_id_particip = .;
Quit;
/*Reponse Q1.3: 101 jouers n'ayant effectué aucun tir da champ pendant la saisin 2018-2019*/

*Q1.4;
proc sql;
	Create table teams_revenues as
		select *,
			ARENACAPACITY*90 as max_game_revenue,
			ARENACAPACITY*90*0.8*41/1000000 as est_annuak_revenue_millions
		from teams;
quit;

*Q1.5.a;

Data teams_revenues_complete;
	set teams_revenues;
	input Arenacapacity;
	Datalines;
18729
18624
17791
21711
19200
19099
18104
19060
19060
19600
17500
19356
19000
19763
20000
18345
19500
18422
19980
17500
18694
19163
19800
20148
18119
20647
21000
19026
20562
19596 
;
RUN;

data test;
  set teams (drop=ARENACAPACITY);
  input TEAM_ID:$10.  MIN_YEAR  ABBREVIATION $ NICKNAME:$13.  YEARFOUNDED4 $ CITY12 $	ARENA26 $ ARENACAPACITY5 $ OWNER26 $ GENERALMANAGER14 $ HEADCOACH $ LEAGUEAFFILIATION@@;
  datalines ;
1610612737	1949	ATL	Hawks	1949	Atlanta	State Farm Arena	18729	Tony Ressler	Travis Schlenk	Lloyd Pierce	Erie Bayhawks
1610612738	1946	BOS	Celtics	1946	Boston	TD Garden	18624	Wyc Grousbeck	Danny Ainge	Brad Stevens	Maine Red Claws
1610612740	2002	NOP	Pelicans	2002	New Orleans	Smoothie King Center	17791	Tom Benson	Trajan Langdon	Alvin Gentry	No Affiliate
1610612741	1966	CHI	Bulls	1966	Chicago	United Center	21711	Jerry Reinsdorf	Gar Forman	Jim Boylen	Windy City Bulls
1610612742	1980	DAL	Mavericks	1980	Dallas	American Airlines Center	19200	Mark Cuban	Donnie Nelson	Rick Carlisle	Texas Legends
1610612743	1976	DEN	Nuggets	1976	Denver	Pepsi Center	19099	Stan Kroenke	Tim Connelly	Michael Malone	No Affiliate
1610612745	1967	HOU	Rockets	1967	Houston	Toyota Center	18104	Tilman Fertitta	Daryl Morey	Mike D'Antoni	Rio Grande Valley Vipers
1610612746	1970	LAC	Clippers	1970	Los Angeles	Staples Center	19060	Steve Ballmer	Michael Winger	Doc Rivers	Agua Caliente Clippers of Ontario
1610612747	1948	LAL	Lakers	1948	Los Angeles	Staples Center	19060	Jerry Buss Family Trust	Rob Pelinka	Frank Vogel	South Bay Lakers
1610612748	1988	MIA	Heat	1988	Miami	AmericanAirlines Arena	19600	Micky Arison	Pat Riley	Erik Spoelstra	Sioux Falls Skyforce
1610612749	1968	MIL	Bucks	1968	Milwaukee	Fiserv Forum	17500	Wesley Edens &Â Marc Lasry	Jon Horst	Mike Budenholzer	Wisconsin Herd
1610612750	1989	MIN	Timberwolves	1989	Minnesota	Target Center	19356	Glen Taylor	Scott Layden	Ryan Saunders	Iowa Wolves
1610612751	1976	BKN	Nets	1976	Brooklyn	Barclays Center	19000	Joe Tsai	Sean Marks	Kenny Atkinson	Long Island Nets
1610612752	1946	NYK	Knicks	1946	New York	Madison Square Garden	19763	Cablevision (James Dolan)	Steve Mills	David Fizdale	Westchester Knicks
1610612753	1989	ORL	Magic	1989	Orlando	Amway Center	20000	Rick DeVos	John Hammond	Steve Clifford	Lakeland Magic
1610612754	1976	IND	Pacers	1976	Indiana	Bankers Life Fieldhouse	18345	Herb Simon	Kevin Pritchard	Nate McMillan	Fort Wayne Mad Ants
1610612755	1949	PHI	76ers	1949	Philadelphia	Wells Fargo Center	19500	Joshua Harris	Elton Brand	Brett Brown	Delaware Blue Coats
1610612756	1968	PHX	Suns	1968	Phoenix	Talking Stick Resort Arena	18422	Robert Sarver	James Jones	Monty Williams	Northern Arizona Suns
1610612757	1970	POR	Trail Blazers	1970	Portland	Moda Center	19980	Paul Allen	Neil Olshey	Terry Stotts	No Affiliate
1610612758	1948	SAC	Kings	1948	Sacramento	Golden 1 Center	17500	Vivek Ranadive	Vlade Divac	Luke Walton	Stockton Kings
1610612759	1976	SAS	Spurs	1976	San Antonio	AT&T Center	18694	Peter Holt	Brian Wright	Gregg Popovich	Austin Spurs
1610612760	1967	OKC	Thunder	1967	Oklahoma Cit	Chesapeake Energy Arena	19163	Clay Bennett	Sam Presti	Billy Donovan	Oklahoma City Blue
1610612761	1995	TOR	Raptors	1995	Toronto	Scotiabank Arena	19800	Maple Leaf Sports and Ente	Masai Ujiri	Nick Nurse	Raptors 905
1610612762	1974	UTA	Jazz	1974	Utah	Vivint Smart Home Arena	20148	Greg Miller	Dennis Lindsey	Quin Snyder	Salt Lake City Stars
1610612763	1995	MEM	Grizzlies	1995	Memphis	FedExForum	18119	Robert Pera	Zach Kleiman	Taylor Jenkins	Memphis Hustle
1610612764	1961	WAS	Wizards	1961	Washington	Capital One Arena	20647	Ted Leonsis	Tommy Sheppard	Scott Brooks	Capital City Go-Go
1610612765	1948	DET	Pistons	1948	Detroit	Little Caesars Arena	21000	Tom Gores	Ed Stefanski	Dwane Casey	Grand Rapids Drive
1610612766	1988	CHA	Hornets	1988	Charlotte	Spectrum Center	19026	Michael Jordan	Mitch Kupchak	James Borrego	Greensboro Swarm
1610612739	1970	CLE	Cavaliers	1970	Cleveland	Quicken Loans Arena	20562	Dan Gilbert	Koby Altman	John Beilein	Canton Charge
1610612744	1946	GSW	Warriors	1946	Golden State	Chase Center	19596	Joe Lacob	Bob Myers	Steve Kerr	Santa Cruz Warriors

;

run;

*Q1.5.a partie 2;
Data table teams_revenues_complete;
	set teams_revenues_complete (drop= max_game_revenue est_annuak_revenue_millions);
	max_game_revenue=ARENACAPACITY*90;
	est_annuak_revenue_millions=ARENACAPACITY*90*0.8*41/1000000;
run;

*Q1.5.b;
proc sql;
	Select mean(est_annuak_revenue_millions)
		from teams_revenues_complete;
quit;


/*Reponse Q1.5.b: la moyenne des revenus annuels estimés est 56.78654 millions de dollars.*/


/* QUESTION 2 */

*Q2.1.a;

Proc sql;
	create table team_game_stats as 
		select 
			distinct team_id,
				game_id,
				sum (FGM) as somme_FGM, 
				sum (FGA) as somme_FGA, 
				Sum (FG3M) as somme_FG3M,
				Sum (FG3A) as somme_FG3A,
				Sum (FTM) as somme_FTM,
				Sum (FTA) as somme_FTA,
				Sum (OREB) as somme_OREB,
				Sum (DREB) as somme_DREB,
				Sum (REB) as somme_REB,
				SUM (STL) as somme_STL,
				sum (BLK) as somme_BLK,
				SUM (TO) as somme_TO,
				Sum (PF) as somme_PF
			from box_scores
				group by game_id, team_id;
Quit;

*Q2.1.b.a;

proc sql;
	create table games_detailed_1 as
		select distinct A.* , 	
			B.somme_FGM as somme_FGM_home,
			B.somme_FGA as somme_FGA_home,
			B.somme_FG3M as somme_FG3M_home,
			B.somme_FG3A as somme_FG3A_home,
			B.somme_FTM as somme_FTM_home,
			B.somme_FTA as somme_FTA_home,
			B.somme_OREB as somme_OREB_home,
			B.somme_DREB as somme_DREB_home,
			B.somme_REB as somme_REB_home,
			B.somme_STL as somme_STL_home,
			B.somme_BLK as somme_BLK_home,
			B.somme_TO as somme_TO_home,
			B.somme_PF as somme_PF_home
		from games as A
			left join team_game_stats as B
				on  A.game_id=B.game_id and A.TEAM_ID_home=B.team_id;
quit;

*Q2.1.b.b;

proc sql;
	create table games_detailed as
		select  A.*,  
			B.somme_FGM as somme_FGM_away,
			B.somme_FGA as somme_FGA_away,
			B.somme_FG3M as somme_FG3M_away,
			B.somme_FG3A as somme_FG3A_away,
			B.somme_FTM as somme_FTM_away,
			B.somme_FTA as somme_FTA_away,
			B.somme_OREB as somme_OREB_away,
			B.somme_DREB as somme_DREB_away,
			B.somme_REB as somme_REB_away,
			B.somme_STL as somme_STL_away,
			B.somme_BLK as somme_BLK_away,
			B.somme_TO as somme_TO_away,
			B.somme_PF as somme_PF_away
		from games_detailed_1 as A
			left join team_game_stats as B
				on A.game_id=B.game_id and A.TEAM_Id_away=B.team_id;
quit;

*Q2.1.b.c Boni;

proc sql;
	create table games_detailed_bonis as
		select  t1.*, 		
			t2.somme_FGM_away, 
			t2.somme_FGA_away, 
			t2.somme_FG3M_away,
			t2.somme_FG3A_away,
			t2.somme_FTM_away,
			t2.somme_FTA_away,
			t2.somme_OREB_away, 
			t2.somme_DREB_away,
			t2.somme_REB_away,
			t2.somme_STL_away,
			t2.somme_BLK_away,
			t2.somme_TO_away,
			t2.somme_PF_away
		from
			(select A.* , 	

				B.somme_FGM as somme_FGM_home,
				B.somme_FGA as somme_FGA_home,
				B.somme_FG3M as somme_FG3M_home,
				B.somme_FG3A as somme_FG3A_home,
				B.somme_FTM as somme_FTM_home,
				B.somme_FTA as somme_FTA_home,
				B.somme_OREB as somme_OREB_home,
				B.somme_DREB as somme_DREB_home,
				B.somme_REB as somme_REB_home,
				B.somme_STL as somme_STL_home,
				B.somme_BLK as somme_BLK_home,
				B.somme_TO as somme_TO_home,
				B.somme_PF as somme_PF_home
			from games as A
				left join team_game_stats as B
					on A.game_id=B.game_id and A.TEAM_ID_home=B.team_id) as t1

				left join 
					(select A.* , 	
						B.somme_FGM as somme_FGM_away,
						B.somme_FGA as somme_FGA_away,
						B.somme_FG3M as somme_FG3M_away,
						B.somme_FG3A as somme_FG3A_away,
						B.somme_FTM as somme_FTM_away,
						B.somme_FTA as somme_FTA_away,
						B.somme_OREB as somme_OREB_away,
						B.somme_DREB as somme_DREB_away,
						B.somme_REB as somme_REB_away,
						B.somme_STL as somme_STL_away,
						B.somme_BLK as somme_BLK_away,
						B.somme_TO as somme_TO_away,
						B.somme_PF as somme_PF_away
					from games as A
						left join team_game_stats as B
							on A.game_id=B.game_id and A.TEAM_ID_away=B.team_id) as t2

							on t1.game_id=t2.game_id;
quit;

*Q2.2;

Data games_w_advanced_stats;
	set games_detailed;
	possessions_home = 0.5*(somme_FGA_home + 0.475* somme_FTA_home - somme_OREB_home +
		somme_TO_home);
	possessions_away = 0.5*(somme_FGA_away + 0.475*somme_FTA_away - somme_OREB_away +
		somme_TO_away);
	offensive_rating_home = 100*PTS_home/(possessions_home + possessions_away);
	defensive_rating_home = 100*PTS_away/(possessions_away + possessions_home);
run;

*Q2.3;
Data box_score_W_advanced_stats;
	SET box_scores;
	effective_FG_perc=(FGM+0.5*FG3M)/FGA;
	true_shooting_perc=PTS/(2*(FGA+0.475*FTA));
	Hollinger_AST_ratio=AST/(FGA+0.475*FTA+AST+TO);
	TO_perc=TO/(FGA+0.475*FTA+AST+TO);
run;

/* QUESTION 3*/

*Q3.1; 


Libname lib_d1 "C:\Alla\Canada\HEC\MATH30602.A2022 - LOGICIELS STATISTIQUES POUR LA GESTION\Devoir1\Lib_d1";

%Macro League_leaders(stat,number);

	proc means data=box_scores nway mean noprint;
		class player_id player_name;
		var &stat;
		output out=resultat
		mean= Moyenne_&stat;
	RUN;

	proc sort data=resultat out=lib_d1.top_%eval(&number)_&stat; where not missing(Moyenne_&stat); by descending Moyenne_&stat;run;

titre --- Aficher les %eval(&number) joueurs avec les meilleures moyennes_&stat---;

	proc print data=lib_d1.top_%eval(&number)_&stat(obs=%eval(&number) keep= player_id player_name Moyenne_&stat); run;

	Data lib_d1.top_%eval(&number)_&stat;
	SET lib_d1.top_%eval(&number)_&stat (obs=&number);
	RUN;

%MEND league_leaders;
%League_leaders_2(AST,15);


*Q3.2;

/*1. Pour obtenir la liste des 15 joueurs avec les meilleures moyennes de passes décisives.*/
%league_leaders_2(AST,15);

/*2. Pour obtenir la liste des 5 joueurs avec les meilleures moyennes de points.*/
%league_leaders_2(PTS,5);

/*3. Pour obtenir la liste des 10 joueurs avec les meilleures moyennes de rebonds
offensifs.*/
%league_leaders_2(OREB,10);



/* FIN du Devoir 1;*/

