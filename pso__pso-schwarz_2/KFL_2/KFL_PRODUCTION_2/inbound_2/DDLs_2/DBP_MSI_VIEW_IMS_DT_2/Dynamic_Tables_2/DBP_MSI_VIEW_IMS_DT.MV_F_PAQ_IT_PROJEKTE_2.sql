CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMS_DT.MV_F_PAQ_IT_PROJEKTE_2
(
	IT_PROJEKT_ID,
	AKTIVIERUNGSQUOTE_INTERN,
	AKTIVIERUNGSQUOTE_EXTERN,
	AKTIVIERUNGSQUOTE_SHS,
	GJ_AKTIVIERUNGSQUOTE_SHS,
	AKTIVIERUNGSQUOTE_INTERN_PLAN,
	AKTIVIERUNGSQUOTE_EXTERN_PLAN,
	AKTIVIERUNGSQUOTE_INTERN_IST,
	AKTIVIERUNGSQUOTE_EXTERN_IST
)
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMS

AS
-- 23.10.2013 AL  neu erstellt Ermittlung PAQ
-- Aktuelle Sicht von FB Gefordert, Zeitpunkt Sichten
-- Outer Join zu Projekt Lookup
-- 17.01.2014 AL in Abstimmung mit Frau Hahn auf KI und DE eingeschränkt
-- 18.10.2017 twie: RITM0413850 Umbenennung ahk_ea_kz zu ahk_aufwand_kz
-- 19.10.2017 twie: RITM0414617 aktivierungsquote_intern in Tabelle ersetzt durch aktivierungsquote_intern_plan, ebenso bei extern
-- 24.10.2017 twie: SPEC0029703 neue Felder aktivierungsquote_intern_plan, aktivierungsquote_extern_plan, aktivierungsquote_intern_ist, aktivierungsquote_extern_ist
-- 14.01.2019 twie: SPEC0046436 Umbau der Stuktur auf neue Tabelle, befüllt aus Clarity

   SELECT
   v01.it_projekt_id,
   COALESCE (v02.aktivierungsquote_intern,0) AS aktivierungsquote_intern,
   COALESCE (v02.aktivierungsquote_extern, 0) AS aktivierungsquote_extern,
   COALESCE (v03.aktivierungsquote_shs, 1)    AS aktivierungsquote_shs,
   COALESCE (v03.gj_aktivierungsquote_shs, 1) AS gj_aktivierungsquote_shs,
   v02.aktivierungsquote_intern_plan,
   v02.aktivierungsquote_extern_plan,
   v02.aktivierungsquote_intern_ist,
   v02.aktivierungsquote_extern_ist


   FROM  dbp_view.v_it_projekt_2 v01
   LEFT JOIN

   (    SELECT plan_revision_id,
   it_projekt_id,
   aktivierungsquote_intern_plan AS aktivierungsquote_intern,
   aktivierungsquote_extern_plan AS aktivierungsquote_extern,
   aktivierungsquote_intern_plan,
   aktivierungsquote_extern_plan,
   aktivierungsquote_intern_ist,
   aktivierungsquote_extern_ist
   FROM  dbp_view.v_it_projekt_plan_2
   WHERE dat_bis= '9999-12-31'
   QUALIFY ROW_NUMBER() OVER (PARTITION BY it_projekt_id ORDER BY plan_revision_id DESC NULLS LAST) = 1
   ) v02
   ON v01.it_projekt_id = v02.it_projekt_id
   LEFT  JOIN

   ( SELECT  v03a.plan_revision_id,
             v03a.it_projekt_id,
             TRUNC( SUM(CASE 
                           WHEN v03a.ahk_aufwand_kz ='AHK'  AND v03a.berichts_position_it_id  IN (1,2,3) 
                           THEN v03a.plan_betrag END) *1.0000 / CASE WHEN SUM(CASE 
                                                                                WHEN  v03a.berichts_position_it_id  IN (1,2,3)  
                                                                                THEN v03a.plan_betrag 
                                                                              END ) = 0 
                                THEN NULL 
                           ELSE SUM(CASE 
                                        WHEN  v03a.berichts_position_it_id  IN (1,2,3)  
                                           THEN v03a.plan_betrag 
                                     END ) 
                         END) *1.0000  aktivierungsquote_shs,
              TRUNC( SUM(CASE 
                             WHEN v03a.ahk_aufwand_kz ='AHK'  AND v03a.berichts_position_it_id  IN (1,2,3) AND v03a.gj = CASE 
                                                                                                                            WHEN EXTRACT (MONTH FROM CURRENT_DATE) <= 3 
                                                                                                                               THEN YEAR(CURRENT_DATE - 1)
                                                                                                                               ELSE YEAR(CURRENT_DATE)
                                                                                                                         END
                                    THEN v03a.plan_betrag 
                         END) *1.0000   / CASE 
                                            WHEN SUM(CASE 
                                                         WHEN  v03a.berichts_position_it_id  IN (1,2,3)  AND v03a.gj = CASE 
                                                                                                                            WHEN EXTRACT (MONTH FROM CURRENT_DATE) <= 3 
                                                                                                                               THEN YEAR(CURRENT_DATE - 1)
                                                                                                                               ELSE YEAR(CURRENT_DATE)
                                                                                                                       END 
                                                                THEN v03a.plan_betrag END ) = 0 
                                                THEN NULL ELSE SUM(CASE 
                                                                     WHEN  v03a.berichts_position_it_id  IN (1,2,3)  AND v03a.gj = CASE 
                                                                                                                                        WHEN EXTRACT (MONTH FROM CURRENT_DATE) <= 3 
                                                                                                                                           THEN YEAR(CURRENT_DATE - 1)
                                                                                                                                           ELSE YEAR(CURRENT_DATE)
                                                                                                                                   END 
                                                THEN v03a.plan_betrag 
                                           END ) 
                         END) *1.0000 gj_aktivierungsquote_shs,
                YEAR(CURRENT_DATE) akt_kj,
                CASE 
                    WHEN EXTRACT (MONTH FROM CURRENT_DATE) <= 3 THEN akt_kj -1
                    ELSE akt_kj
                END AS akt_gj
    FROM  dbp_view.v_it_projekt_plan_det_2 v03a

    --it_plan_ebene_id ist nicht mehr in it_projekt_plan_det_2 vorhanden, deshalb für Filterung auf KI und DE ein Join zur it_projekt_verteilung_laender_2 nötig
    INNER  JOIN
        (SELECT
                it_projekt_id,
                berichts_position_it_id,
                gj
         FROM  dbp_view.v_it_projekt_verteilung_laender_2
         WHERE it_plan_ebene_id IN (1,2)
         GROUP BY 1,2,3
   ) v03b
   ON  v03a.it_projekt_id = v03b.it_projekt_id AND v03a.berichts_position_it_id = v03b.berichts_position_it_id AND v03a.gj = v03b.gj
   GROUP BY  v03a.plan_revision_id,
   v03a.it_projekt_id
   )  v03
   ON
   v02.plan_revision_id             = v03.plan_revision_id AND
   v02.it_projekt_id                  = v03.it_projekt_id
   ;