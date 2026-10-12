CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_WWC.MV_COI_UMP_UMSATZPLAN_HWG_1
-- 16.10.2018, srom0404, Anpassung bzgl. bereinigter Kennzahlen
-- coi_ump_hwg_sum_1 gibt es auch als eigene View. Auf Grund des aktuellen Schema und der unterschiedlichen Ebenen
-- zwischen den Tabellen coi_ump_umsatzplan_hwg_1 und coi_ump_hwg_sum_1 war ein Zusammenbringen im FrontEnd nicht möglich
-- Bei bereinigten PLAN Metriken wurde coi_ump_umsatzplan_hwg_1 zu coi_ump_wup_1 immer ohne version_id ge-joint. Daher wurde Attribut Betrieb
-- als Eltern von Plan-Markt genommen (was auch Logisch scheint). PLAN Bereinigt ist damit richtig, aber die IST Fakten scheinen nicht mehr auf der richtigen Ebene.
-- Mehrere FrontEnd Schema Varianten brachten kein Ergebnis. Daher hier der Join.

-- Die Transformation auf Vorjahreswerte (Datum-genau als auch Wochentag-genau) erfolgt ebenfalls hir, da dann in MSI direkt auf der gewünschten Zielebene gerechnet werden kann
-- 15.08.2019, mcie, renaming umsatz_netto_basis to umsatz_netto_basis_1, umsatz_netto_referenz to umsatz_netto_basis_3 and adding umsatz_netto_basis_2
-- 16.08.2019, mcie, added referenzgrund_vj and referenzgrund_vj_kt
-- 29.08.2019, mcie1607, added where clause betriebsunterbrechung_fg =1
-- 25.09.2019, cbru1709, Änderungen wegen Berechnung VJ Felder im Backend
-- 06.11.2019, cbru1709, 29.2. Änderung wegen WT Rückblick
-- 16.01.2020, srom0404, intern, Anhebung der Zahlenskalierung für implizites Casting in Bericht-SQL
-- 07.10.2020, staniszewskp, -VVJ new columns in the table
-- 12.10.2020, srom0404, AP0071646, SPEC0086997, weitere Anpassungen bzgl. VVJ Metriken
-- 29.10.2020, anpassung der referenzgrundlogik von dat_plan-365 auf dat_referenz
-- 29.10.2020, lwei0109, AP0071646, anpassung schaltjareslogik bei den joins v03_vj_kt und v03_vvj_kt
-- 19.11.2021, prescherad, INC3743915, Umsatzplanung Referenzeffekte, VorJWerte
(
mandant_id
,gj_plan
,version_id
,wup_id
,nb_id
,dat_plan
,arthiertyp_id
,hwg_id
,wrg_id
,land_level
,vs_id
,wup_id_referenz
,dat_referenz
,faktor_kalender
,faktor_basis
,faktor_wup_referenz
,umsatz_netto_basis_1
,umsatz_netto_basis_2
,umsatz_netto_basis_3
,umsatz_netto_plan
,wup_geoeffnet_fg
,umsatz_netto_ist
,umsatz_netto_ist_vj
,umsatz_netto_ist_vj_kt

,umsatz_netto_ist_vvj
,umsatz_netto_ist_vvj_kt

,referenzgrund_id_vj
,referenzgrund_id_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,referenzgrund_id_vvj
,referenzgrund_id_vvj_kt

--,umsatz_netto_basis_vj
--,faktor_wup_referenz_vj

--,umsatz_netto_basis_vj_kt
--,faktor_wup_referenz_vj_kt

,umsatz_netto_plan_vj
,umsatz_netto_plan_vj_kt

,umsatz_basis_vj
,umsatz_basis_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
--,umsatz_netto_plan_vvj
--,umsatz_netto_plan_vvj_kt

-- VVJ changes, AP0071646, SPEC0086997
,umsatz_basis_vvj
,umsatz_basis_vvj_kt

,umsatz_kalendereffekt_vj
,umsatz_kalendereffekt_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,umsatz_kalendereffekt_vvj
,umsatz_kalendereffekt_vvj_kt

,umsatz_referenzeffekt_vj
,umsatz_referenzeffekt_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,umsatz_referenzeffekt_vvj
,umsatz_referenzeffekt_vvj_kt

,umsatz_plan_vj_fg
,umsatz_plan_vj_kt_fg

,betriebsunterbrechung_fg

) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_WWC 
AS
SELECT
 dt1.mandant_id
,dt1.gj_plan
,dt1.version_id
,dt1.wup_id
,dt1.nb_id
,dt1.dat_plan
,dt1.arthiertyp_id
,dt1.hwg_id
,dt1.wrg_id
,dt1.land_level
,dt1.vs_id
,dt1.wup_id_referenz
,dt1.dat_referenz
,dt1.faktor_kalender
,dt1.faktor_basis
,dt1.faktor_wup_referenz
,dt1.umsatz_netto_basis_1
,dt1.umsatz_netto_basis_2
,dt1.umsatz_netto_basis_3
,dt1.umsatz_netto_plan
,dt1.wup_geoeffnet_fg
,dt1.umsatz_netto_ist
,dt1.umsatz_netto_ist_vj
,dt1.umsatz_netto_ist_vj_kt

,dt1.umsatz_netto_ist_vvj
,dt1.umsatz_netto_ist_vvj_kt

,dt1.referenzgrund_id_vj
,dt1.referenzgrund_id_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,dt1.referenzgrund_id_vvj
,dt1.referenzgrund_id_vvj_kt

--,dt1.umsatz_netto_basis_vj
--,dt1.faktor_wup_referenz_vj

--,dt1.umsatz_netto_basis_vj_kt
--,dt1.faktor_wup_referenz_vj_kt

,dt1.umsatz_netto_plan_vj
,dt1.umsatz_netto_plan_vj_kt

,dt1. umsatz_basis_vj
,dt1. umsatz_basis_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
--,dt1.umsatz_netto_plan_vvj
--,dt1.umsatz_netto_plan_vvj_kt

-- VVJ changes, AP0071646, SPEC0086997
,dt1. umsatz_basis_vvj
,dt1. umsatz_basis_vvj_kt

-- Kalendereffekt = Referenzumsatz - Basisumsatz VJ (KT/WT)
,dt1.umsatz_kalendereffekt_vj
,dt1.umsatz_kalendereffekt_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,dt1.umsatz_kalendereffekt_vvj
,dt1.umsatz_kalendereffekt_vvj_kt

-- Referenzeffekt = Basisumsatz VJ (KT/WT) - Umsatz RF (KT/WT)
,dt1.umsatz_referenzeffekt_vj
,dt1.umsatz_referenzeffekt_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,dt1.umsatz_referenzeffekt_vvj
,dt1.umsatz_referenzeffekt_vvj_kt

,dt1.umsatz_plan_vj_fg
,dt1.umsatz_plan_vj_kt_fg

,dt1.betriebsunterbrechung_fg

FROM
( --dt1
SELECT
v01.mandant_id
,v01.gj_plan
,v01.version_id
,v01.wup_id
,v01.nb_id
,v01.dat_plan
,v01.arthiertyp_id
,v01.hwg_id
,v01.wrg_id
,v01.land_level
,v01.vs_id
,v01.wup_id_referenz
,v01.dat_referenz
-- explizites Casting, damit es zu keinem numeric overflow bei Berichts SQL durch implizites Casting kommt
-- Beispiel Metrik [Umsatzeffekt Kalender] wird in Bericht mit impliziten Casting berechnet durch  
-- sum((a11.umsatz_netto_basis_1 * (a11.faktor_kalender + a11.faktor_wup_referenz)))  UmsatzeffektKalender
-- umsatz_netto_basis_1 hat DECIMAL(18,4)
-- faktor_kalender hat DECIMAL(14,10)
-- die Zahlenlänge ergibt sich aus der größten Zahlenlänge (hier 18)
-- duch Multiplikation wird die Genauigkeit der Nachkommastelle addiert (also 4 + 10 = 14)
-- es ergibt sich also DECIMAL(18,14), damit bleiben 4 Stellen vor dem Komma, das berechnete Ergebnis passt nicht rein
-- durch 'anheben' der Skalierung auf DECIMAL(24,10) passt das Ergebnis bei impliziten Cast dann wieder rein 
-- Zahlenlänge ist 24, davon sind 14 (10+4) Stellen für Nachkomma und es bleiben 10 Stellen vor dem Komma
,Cast(v01.faktor_kalender AS DECIMAL(24,10)) AS faktor_kalender
,Cast(v01.faktor_basis  AS DECIMAL(24,10)) AS faktor_basis
,Cast(v01.faktor_wup_referenz AS DECIMAL(24,10)) AS faktor_wup_referenz
,v01.umsatz_netto_basis_1
,v01.umsatz_netto_basis_2
,v01.umsatz_netto_basis_3
,v01.umsatz_netto_plan
,v01.wup_geoeffnet_fg
,v03.umsatz_netto AS umsatz_netto_ist
,v03_vj.umsatz_netto AS umsatz_netto_ist_vj
,v03_vj_kt.umsatz_netto AS umsatz_netto_ist_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,v03_vvj.umsatz_netto AS umsatz_netto_ist_vvj
,v03_vvj_kt.umsatz_netto AS umsatz_netto_ist_vvj_kt

,Coalesce(v04_vj.referenzgrund_id, -1) AS referenzgrund_id_vj
,Coalesce(v04_vj_kt.referenzgrund_id, -1) AS referenzgrund_id_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,Coalesce(v04_vvj.referenzgrund_id, -1) AS referenzgrund_id_vvj
,Coalesce(v04_vvj_kt.referenzgrund_id, -1) AS referenzgrund_id_vvj_kt

--,v05_vj.umsatz_netto_basis AS umsatz_netto_basis_vj
--,v05_vj.faktor_wup_referenz AS faktor_wup_referenz_vj
--,v05_vj_kt.umsatz_netto_basis AS umsatz_netto_basis_vj_kt
--,v05_vj_kt.faktor_wup_referenz AS faktor_wup_referenz_vj_kt

-- laut Anforderung:
-- Kalendereffekt = Referenzumsatz - Basisumsatz VJ (KT/WT)
-- Referenzeffekt = Basisumsatz VJ (KT/WT) - Umsatz RF (KT/WT)
-- Wobei:
-- Basisumsatz VJ (KT/WT) = CASE WHEN Referenzfiliale [Plan Dat VJ KT/WT] IS NULL
--                               THEN Umsatz RF (KT/WT) [Filiale]
--                               ELSE  Umsatz RF (KT/WT) [Referenzfiliale] * (1 + Referenzfaktor [Plan Dat VJ KT/WT])
--
-- UND:
-- Umsatz RF = COALESCE(UmsatzPLAN VJ, UmsatzIST  VJ)

--,v05_vj.umsatz_netto_plan AS umsatz_netto_plan_vj --> Die Berechnung wurde ins Backend verschoben
,v01.umsatz_netto_plan_vj
--,v05_vj_kt.umsatz_netto_plan AS umsatz_netto_plan_vj_kt --> Die Berechnung wurde ins Backend verschoben
,v01.umsatz_netto_plan_vj_kt
		
--,v041_vj.umsatz_netto_plan AS umsatz_netto_plan_ref
--,v042_vj.umsatz_netto AS umsatz_netto_ref

/*-- Ermittlung Umsatz RF anhand des Flag zur Steuerung, ob vom Vorjahr Plan-Werte oder Ist-Werte genommen werden
,CASE WHEN v04_vj.wup_id_referenz IS NULL
-- bisher THEN COALESCE(v05_vj.umsatz_netto_plan, v03_vj.umsatz_netto, 0)  -- Umsatz RF der Plan Filiale
THEN CASE WHEN umsatz_plan_vj_fg = 1 THEN COALESCE(v05_vj.umsatz_netto_plan,0) ELSE COALESCE( v03_vj.umsatz_netto,0) END
-- bisher ELSE COALESCE(v041_vj.umsatz_netto_plan,v042_vj.umsatz_netto, 0) * (1 + v04_vj.faktor_wup_referenz)
ELSE CASE WHEN umsatz_plan_vj_fg = 1 THEN COALESCE(v041_vj.umsatz_netto_plan,0) * (1 + v04_vj.faktor_wup_referenz)  ELSE COALESCE(v042_vj.umsatz_netto, 0) *  (1 + v04_vj.faktor_wup_referenz) END
END AS umsatz_basis_vj*/
,v01.umsatz_basis_vj

/*,CASE WHEN v04_vj_kt.wup_id_referenz IS NULL
-- bisher THEN COALESCE(v05_vj_kt.umsatz_netto_plan, v03_vj_kt.umsatz_netto, 0)  -- Umsatz RF der Plan Filiale
THEN CASE WHEN umsatz_plan_vj_kt_fg = 1 THEN COALESCE(v05_vj_kt.umsatz_netto_plan,0) ELSE COALESCE( v03_vj_kt.umsatz_netto,0) END
-- bisher ELSE COALESCE(v041_vj_kt.umsatz_netto_plan,v042_vj_kt.umsatz_netto, 0) * (1 + v04_vj_kt.faktor_wup_referenz)
ELSE CASE WHEN umsatz_plan_vj_kt_fg = 1 THEN COALESCE(v041_vj_kt.umsatz_netto_plan,0) * (1 + v04_vj_kt.faktor_wup_referenz)  ELSE COALESCE(v042_vj_kt.umsatz_netto, 0) *  (1 + v04_vj_kt.faktor_wup_referenz) END
END AS umsatz_basis_vj_kt*/
,v01.umsatz_basis_vj_kt
		
		
-- VVJ changes, AP0071646, SPEC0086997
,v01.umsatz_basis_vvj

,v01.umsatz_basis_vvj_kt

-- Kalendereffekt = Referenzumsatz - Basisumsatz VJ (KT/WT)
,Coalesce(v01.umsatz_netto_basis_3,0) - v01.umsatz_basis_vj    AS umsatz_kalendereffekt_vj
,Coalesce(v01.umsatz_netto_basis_3,0) - v01.umsatz_basis_vj_kt AS umsatz_kalendereffekt_vj_kt

--VVJ changes, AP0071646, SPEC0086997
,Coalesce(v01.umsatz_netto_basis_3,0) - v01.umsatz_basis_vvj    AS umsatz_kalendereffekt_vvj
,Coalesce(v01.umsatz_netto_basis_3,0) - v01.umsatz_basis_vvj_kt AS umsatz_kalendereffekt_vvj_kt

-- VVJ- check with Sascha
-- Kalendereffekt = Referenzumsatz - Basisumsatz VJ (KT/WT)
--,Coalesce(v01.umsatz_netto_basis_3,0) - umsatz_basis_vvj    AS umsatz_kalendereffekt_vj
--,Coalesce(v01.umsatz_netto_basis_3,0) - umsatz_basis_vvj_kt AS umsatz_kalendereffekt_vj_kt

-- Flag zur Steuerung, ob vom Vorjahr Plan-Werte oder Ist-Werte genommen werden
-- dat_planwerte_ist_ab wird über die Upload Datei mitgegeben
-- jeweils für KT/WT
,CASE WHEN v02.dat_vj >= v06.dat_planwerte_ist_ab
 THEN 1
 ELSE 0
 END AS umsatz_plan_vj_fg
   
,CASE WHEN (CASE v02.gjtag_id WHEN 366 THEN TO_DATE('1900-01-01') ELSE dateadd(YEAR,-1,v01.dat_plan) END) >= v06.dat_planwerte_ist_ab
 THEN 1
 ELSE 0
 END AS umsatz_plan_vj_kt_fg

-- Referenzeffekt = Basisumsatz VJ (KT/WT) - Umsatz RF (KT/WT)
-- bisher umsatz_rf_vj - COALESCE(v05_vj.umsatz_netto_plan, v03_vj.umsatz_netto, 0) AS umsatz_referenzeffekt_vj
,v01.umsatz_basis_vj - CASE WHEN umsatz_plan_vj_fg = 1 THEN Coalesce(umsatz_netto_plan_vj,0) ELSE Coalesce( v03_vj.umsatz_netto,0) END AS umsatz_referenzeffekt_vj
-- bisher umsatz_rf_vj_kt - COALESCE(v05_vj_kt.umsatz_netto_plan, v03_vj_kt.umsatz_netto, 0) AS umsatz_referenzeffekt_vj_kt
,v01.umsatz_basis_vj_kt - CASE WHEN umsatz_plan_vj_kt_fg = 1 THEN Coalesce(umsatz_netto_plan_vj_kt,0) ELSE Coalesce( v03_vj_kt.umsatz_netto,0) END AS umsatz_referenzeffekt_vj_kt

-- VVJ changes, AP0071646, SPEC0086997
,v01.umsatz_basis_vvj - Coalesce(v03_vvj.umsatz_netto,0) AS umsatz_referenzeffekt_vvj
,v01.umsatz_basis_vvj_kt - Coalesce(v03_vvj_kt.umsatz_netto,0) AS umsatz_referenzeffekt_vvj_kt

																			   
															  
					 
												 
	  
	  
					 

																																
	  
	  
						

,Coalesce(v07.betriebsunterbrechung_fg,0) AS betriebsunterbrechung_fg

FROM dbp_view.v_coi_ump_umsatzplan_hwg_1 v01

LEFT JOIN dbp_view.v_tag_1 v02
ON v01.dat_plan = v02.dat

LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v03 -- aktuell
ON v01.mandant_id = v03.mandant_id
AND v01.wup_id = v03.wup_id
AND v01.nb_id = v03.nb_id
AND v01.dat_plan = v03.dat
AND v01.hwg_id = v03.hwg_id
AND v01.wrg_id = v03.wrg_id

-- VJ Wochentag genau (Montag auf Montag)
-- Hier wird UmsatzIst VJ der PlanFiliale ermittelt
LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v03_vj
ON v01.mandant_id = v03_vj.mandant_id
AND v01.wup_id     = v03_vj.wup_id
AND v01.nb_id      = v03_vj.nb_id
AND v02.dat_vj = v03_vj.dat
AND v01.hwg_id = v03_vj.hwg_id
AND v01.wrg_id = v03_vj.wrg_id

-- VJ KT Datum genau (01.09.2018 auf 01.09.2017)
-- Hier wird UmsatzIst VJ KT der PlanFiliale ermittelt
/**
LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v03_vj_kt
ON v01.mandant_id = v03_vj_kt.mandant_id
AND v01.wup_id     = v03_vj_kt.wup_id
AND v01.nb_id      = v03_vj_kt.nb_id
AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE Add_Months(v01.dat_plan,-12) END = v03_vj_kt.dat
AND v01.hwg_id = v03_vj_kt.hwg_id
AND v01.wrg_id = v03_vj_kt.wrg_id
**/

-- VJ KT Datum genau (01.09.2018 auf 01.09.2017)
-- Hier wird UmsatzIst VJ KT der PlanFiliale ermittelt
LEFT JOIN (SELECT mandant_id
                 ,wup_id
                 ,nb_id
                 ,CASE WHEN dat='2020-02-29' THEN TO_DATE('2020-02-28') ELSE dat END AS dat_
                 ,hwg_id
                 ,wrg_id
                 ,Sum(umsatz_netto) AS umsatz_netto
           FROM dbp_view.v_coi_ump_hwg_sum_1
           GROUP BY mandant_id
                   ,wup_id
                   ,nb_id 
                   ,dat_ 
                   ,hwg_id
                   ,wrg_id
           ) v03_vj_kt

ON v01.mandant_id = v03_vj_kt.mandant_id
AND v01.wup_id    = v03_vj_kt.wup_id
AND v01.nb_id     = v03_vj_kt.nb_id
AND CASE v02.gjtag_id WHEN 366 THEN TO_DATE('1900-01-01') ELSE dateadd(YEAR,-1,v01.dat_plan) END = v03_vj_kt.dat_
AND v01.hwg_id = v03_vj_kt.hwg_id
AND v01.wrg_id = v03_vj_kt.wrg_id

-- VVJ changes, AP0071646, SPEC0086997
-- VVJ Wochentag genau (Montag auf Montag)
-- Hier wird UmsatzIst VJ der PlanFiliale ermittelt
LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v03_vvj
ON v01.mandant_id   = v03_vvj.mandant_id
AND v01.wup_id      = v03_vvj.wup_id
AND v01.nb_id       = v03_vvj.nb_id
AND v02.dat_vj -364 = v03_vvj.dat
AND v01.hwg_id      = v03_vvj.hwg_id
AND v01.wrg_id      = v03_vvj.wrg_id

-- VVJ changes, AP0071646, SPEC0086997
-- VVJ KT Datum genau (01.09.2018 auf 01.09.2016)
-- Hier wird UmsatzIst VJ KT der PlanFiliale ermittelt
/***
LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v03_vvj_kt
ON v01.mandant_id  = v03_vvj_kt.mandant_id
AND v01.wup_id     = v03_vvj_kt.wup_id
AND v01.nb_id      = v03_vvj_kt.nb_id
AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE Add_Months(v01.dat_plan,-24) END = v03_vvj_kt.dat
AND v01.hwg_id = v03_vvj_kt.hwg_id
AND v01.wrg_id = v03_vvj_kt.wrg_id
**/

LEFT JOIN (SELECT mandant_id
                 ,wup_id
                 ,nb_id
                 ,CASE WHEN dat='2020-02-29' THEN TO_DATE('2020-02-28') ELSE dat END AS dat_
                 ,hwg_id
                 ,wrg_id
                 ,Sum(umsatz_netto) AS umsatz_netto
           FROM dbp_view.v_coi_ump_hwg_sum_1
           GROUP BY mandant_id
                   ,wup_id
                   ,nb_id 
                   ,dat_ 
                   ,hwg_id
                   ,wrg_id
            )
            v03_vvj_kt
			
ON v01.mandant_id = v03_vvj_kt.mandant_id
AND v01.wup_id    = v03_vvj_kt.wup_id
AND v01.nb_id     = v03_vvj_kt.nb_id
AND CASE v02.gjtag_id WHEN 366 THEN TO_DATE('1900-01-01') ELSE dateadd(YEAR,-2,v01.dat_plan) END = v03_vvj_kt.dat_
AND v01.hwg_id    = v03_vvj_kt.hwg_id
AND v01.wrg_id    = v03_vvj_kt.wrg_id

			--Durch die erweiterte Backendlogik können diese Joins eingespart werden
				/*-- VJ Wochentag genau (Montag auf Montag)
				-- Hier wird UmsatzPlan VJ der PlanFiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_umsatzplan_hwg_1 v05_vj
				ON v01.mandant_id = v05_vj.mandant_id
				AND v01.wup_id     = v05_vj.wup_id
				AND v01.nb_id      = v05_vj.nb_id
				AND v01.hwg_id     = v05_vj.hwg_id
				AND v01.version_id = v05_vj.version_id
				AND v01.gj_plan    = v05_vj.gj_plan
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE v02.dat_vj END = v05_vj.dat_plan

				-- VJ KT Datum genau (01.09.2018 auf 01.09.2017)
				-- Hier wird UmsatzPlan VJ KT der PlanFiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_umsatzplan_hwg_1 v05_vj_kt
				ON v01.mandant_id = v05_vj_kt.mandant_id
				AND v01.wup_id     = v05_vj_kt.wup_id
				AND v01.nb_id      = v05_vj_kt.nb_id
				AND v01.hwg_id     = v05_vj_kt.hwg_id
				AND v01.version_id = v05_vj_kt.version_id
				AND v01.gj_plan    = v05_vj_kt.gj_plan
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE ADD_MONTHS(v01.dat_plan,-12) END = v05_vj_kt.dat_plan
				*/
------------------------------------------- Begin Referenzfiliale -----------------------------------------------------
-- Referenzfiliale zum PlanTag VJ
-- VJ Wochentag genau (Montag auf Montag)
LEFT JOIN dbp_view.v_coi_ump_wup_1 v04_vj
 ON v01.mandant_id = v04_vj.mandant_id
AND v01.gj_plan    = v04_vj.gj_plan
AND v01.version_id = v04_vj.version_id
AND v01.wup_id     = v04_vj.wup_id
AND v01.nb_id      = v04_vj.nb_id
AND v02.dat_vj BETWEEN v04_vj.dat_wup_ref_von AND v04_vj.dat_wup_ref_bis

-- Referenzfiliale zum PlanTag VJ KT
-- VJ KT Datum genau (01.09.2018 auf 01.09.2017)
LEFT JOIN dbp_view.v_coi_ump_wup_1 v04_vj_kt
 ON v01.mandant_id = v04_vj_kt.mandant_id
AND v01.gj_plan    = v04_vj_kt.gj_plan
AND v01.version_id = v04_vj_kt.version_id
AND v01.wup_id     = v04_vj_kt.wup_id
AND v01.nb_id      = v04_vj_kt.nb_id
--AND CASE v02.gjtag_id WHEN 366 THEN TO_DATE('1900-01-01') ELSE dateadd(YEAR,-1,v01.dat_plan) END BETWEEN v04_vj_kt.dat_wup_ref_von AND v04_vj_kt.dat_wup_ref_bis
AND v01.dat_referenz BETWEEN v04_vj_kt.dat_wup_ref_von AND v04_vj_kt.dat_wup_ref_bis

-- VVJ changes, AP0071646, SPEC0086997
-- Referenzfiliale zum PlanTag VVJ
-- VVJ Wochentag genau (Montag auf Montag)
LEFT JOIN dbp_view.v_coi_ump_wup_1 v04_vvj
 ON v01.mandant_id = v04_vvj.mandant_id
AND v01.gj_plan    = v04_vvj.gj_plan
AND v01.version_id = v04_vvj.version_id
AND v01.wup_id     = v04_vvj.wup_id
AND v01.nb_id      = v04_vvj.nb_id
AND v02.dat_vj -364 BETWEEN v04_vvj.dat_wup_ref_von AND v04_vvj.dat_wup_ref_bis

-- VVJ changes, AP0071646, SPEC0086997
-- Referenzfiliale zum PlanTag VVJ KT
-- VVJ KT Datum genau (01.09.2018 auf 01.09.2016)
LEFT JOIN dbp_view.v_coi_ump_wup_1 v04_vvj_kt
 ON v01.mandant_id = v04_vvj_kt.mandant_id
AND v01.gj_plan    = v04_vvj_kt.gj_plan
AND v01.version_id = v04_vvj_kt.version_id
AND v01.wup_id     = v04_vvj_kt.wup_id
AND v01.nb_id      = v04_vvj_kt.nb_id
AND v01.dat_referenz BETWEEN v04_vvj_kt.dat_wup_ref_von AND v04_vvj_kt.dat_wup_ref_bis
--AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE Add_Months(v01.dat_plan,-24) END BETWEEN v04_vvj_kt.dat_wup_ref_von AND v04_vvj_kt.dat_wup_ref_bis
			
			--Durch die erweiterte Backendlogik können diese Joins eingespart werden
				/*-- Kennzahlen der Referenzfiliale zum PlanTag VJ Wochentag genau (Montag auf Montag)
				-- Das Referenzdatum von PLanFiliale + und PlanTag wird genommen als PlanTag für die zu suchenden Werte der Referenzfiliale
				-- Hier wird UmsatzPlan VJ der Referenzfiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_umsatzplan_hwg_1 v041_vj
				ON v01.mandant_id         = v041_vj.mandant_id
				AND v04_vj.wup_id_referenz = v041_vj.wup_id
				AND v01.nb_id              = v041_vj.nb_id
				AND v01.hwg_id             = v041_vj.hwg_id
				AND v01.version_id         = v041_vj.version_id
				AND v01.gj_plan            = v041_vj.gj_plan
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE v02.dat_vj END = v041_vj.dat_plan

				-- Kennzahlen der Referenzfiliale zum PlanTag VJ Wochentag genau (Montag auf Montag)
				-- PlanTag VJ von PlanFiliale wird genommen als PlanTag für die zu suchenden Werte der Referenzfiliale
				-- Hier wird UmsatzIst VJ der Referenzfiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v042_vj
				ON v01.mandant_id         = v042_vj.mandant_id
				AND v04_vj.wup_id_referenz = v042_vj.wup_id
				AND v01.nb_id              = v042_vj.nb_id
				AND v01.hwg_id             = v042_vj.hwg_id
				AND v01.wrg_id             = v042_vj.wrg_id
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE v02.dat_vj END = v042_vj.dat
				
				
				-- Kennzahlen der Referenzfiliale zum PlanTag VJ KT Datum genau (01.09.2018 auf 01.09.2017)
				-- PlanTag VJ KT von PlanFiliale wird genommen als PlanTag für die zu suchenden Werte der Referenzfiliale
				-- Hier wird UmsatzPlan VJ der Referenzfiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_umsatzplan_hwg_1 v041_vj_kt
				ON v01.mandant_id            = v041_vj_kt.mandant_id
				AND v04_vj_kt.wup_id_referenz = v041_vj_kt.wup_id
				AND v01.nb_id                 = v041_vj_kt.nb_id
				AND v01.hwg_id                = v041_vj_kt.hwg_id
				AND v01.version_id            = v041_vj_kt.version_id
				AND v01.gj_plan               = v041_vj_kt.gj_plan
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE ADD_MONTHS(v01.dat_plan,-12) END = v041_vj_kt.dat_plan

				-- Kennzahlen der Referenzfiliale zum PlanTag VJ KT Datum genau (01.09.2018 auf 01.09.2017)
				-- PlanTag VJ KT von PlanFiliale wird genommen als PlanTag für die zu suchenden Werte der Referenzfiliale
				-- Hier wird UmsatzIst VJ der Referenzfiliale ermittelt
				LEFT JOIN dbp_view.v_coi_ump_hwg_sum_1 v042_vj_kt
				ON v01.mandant_id            = v042_vj_kt.mandant_id
				AND v04_vj_kt.wup_id_referenz = v042_vj_kt.wup_id
				AND v01.nb_id                 = v042_vj_kt.nb_id
				AND v01.hwg_id                = v042_vj_kt.hwg_id
				AND v01.wrg_id                = v042_vj_kt.wrg_id
				AND CASE v02.gjtag_id WHEN 366 THEN DATE '1900-01-01' ELSE ADD_MONTHS(v01.dat_plan,-12) END = v042_vj_kt.dat
				*/
------------------------------------------- Ende Referenzfiliale -----------------------------------------------------

LEFT JOIN dbp_view.v_coi_ump_version_1 v06
ON v01.mandant_id = v06.mandant_id
AND v01.gj_plan    = v06.gj_plan
AND v01.version_id = v06.version_id

-- Ermittlung, ob eine_1 Betriebsunterbrechung vorliegt. Bei Betriebsunterbrechung soll der Kalendereffekt dem zum Datum passenden Immo Effekt zugeordnet werden
LEFT JOIN dbp_view.v_coi_ump_wup_immo_massnahme_per_1 v07
ON v01.mandant_id = v07.mandant_id
AND v01.wup_id     = v07.wup_id
AND v01.nb_id      = v07.nb_id
AND v01.version_id = v07.version_id
AND v01.gj_plan    = v07.gj_plan
AND v01.dat_plan BETWEEN v07.dat_immo_auswirkung_von AND v07.dat_immo_auswirkung_bis
AND v07.betriebsunterbrechung_fg =1
) dt1;