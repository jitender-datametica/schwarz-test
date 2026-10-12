CREATE OR REPLACE PROCEDURE DBP_MACRO.M_UPS_TS_WBS_ARTIKEL_MARKT_MASSENBEARBEITUNG(
    "P_MANDANT_ID" FLOAT, 
    "P_DAT_VON" VARCHAR, 
    "P_DAT_BIS" VARCHAR, 
    "P_ART_IDS" VARCHAR, 
    "P_WUPS" VARCHAR, 
    "P_ANGEBOTE" VARCHAR, 
    "P_ADJUSTMENT_FG" FLOAT, 
    "P_FAKTOR_REST_VON_NORMALBESTAND" NUMBER(38,3), 
    "P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ" NUMBER(38,3), 
    "P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ" NUMBER(38,3))
RETURNS VARCHAR(16777216)
LANGUAGE SQL
COMMENT='Massenbearbeitung auf Artikelebene WBS'
EXECUTE AS OWNER

AS 
$$

DECLARE 
dummy_2 float;

BEGIN 

---------------------------
------ STEP 1 UPDATE ------


IF (:P_ADJUSTMENT_FG IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_wbs_art_aktion_markt_2 
set ADJUSTMENT_ID =  :P_ADJUSTMENT_FG  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
AND ART_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.value) > 1)
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPs, ',')) AS table1 )
AND ANGEBOT_NR IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 );
END IF;

IF (:P_FAKTOR_REST_VON_NORMALBESTAND IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_wbs_art_aktion_markt_2 
set REST_VON_NORMALBESTAND_PROZ =  :P_FAKTOR_REST_VON_NORMALBESTAND  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
AND ART_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.value) > 1)
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPS, ',')) AS table1 )
AND ANGEBOT_NR IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 );
END IF;

IF (:P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_wbs_art_aktion_markt_2 
set NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ =  :P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
AND ART_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.value) > 1)
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPS, ',')) AS table1 )
AND ANGEBOT_NR IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 );
END IF;

IF (:P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ IS NOT NULL) then 
-- Wenn wir alles hier setzen dann könnten wir dies so machen 
UPDATE  DBP_DATA.ts_wbs_art_aktion_markt_2 
set NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ =  :P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ  
WHERE MANDANT_ID = :P_MANDANT_ID 
AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
AND ART_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.value) > 1)
AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPS, ',')) AS table1 )
AND ANGEBOT_NR IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 );
END IF;

---------------------------
------ STEP 2 INSERT ------
--- Alle Artikel_2 die vorhanden sind 

INSERT INTO DBP_DATA.ts_wbs_art_aktion_markt_2 (
mandant_id,
wup_id,
nb_id,
art_id,
aktion_id,
angebot_nr,
dat_von,
dat_bis,
gk_fg,
menge_mindestplatzierung_bme,
top_gk_fg,
fixmenge_wfl_bme,
td_update,
td_insert,
adjustment_id,
max_kapa_fg,
dat_letzte_nachversorgung,
rest_von_normalbestand_proz,
NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ
)

WITH Art_UPDATE AS
    (SELECT * FROM DBP_DATA.ts_wbs_art_aktion_markt_2 
     WHERE MANDANT_ID = :P_MANDANT_ID
     AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
     AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
     AND ART_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 )
     AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPS, ',')) AS table1 )
     AND ANGEBOT_NR IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1  )
    ),
Angebot_Artikel AS (
SELECT DISTINCT
 aaw.mandant_id
--,a.kjwo_ww
,agw.auslieferungsgruppe_id AS ausliefergruppe_id
,t.kjwo AS kjwo
,ww.kjwo_ww
,COALESCE(CASE WHEN aaw.ANGEBOT_NR = '' THEN NULL ELSE aaw.ANGEBOT_NR END,'n/a') AS angebot_id
,COALESCE(CASE WHEN a.aktion_id = '' THEN NULL ELSE a.aktion_id END ,'n/a') AS AKTION_ID
,a.ANGEBOT_TYP_CD AS BONUSKAUF_PROMOTIONSTYP
,aaw.art_id
,aaw.wup_id
,aaw.nb_id AS nb_id
,agw.mandant_id AS mandant_id_vz
--,CASE WHEN ag.auslieferungsgruppe_id = 'VEN' THEN a_gp.gp_id ELSE ag.gp_id END AS wup_id_vz
,CASE WHEN LENGTH(TO_VARCHAR(ABS(agw.gp_id))) <= 4 THEN agw.gp_id ELSE -9 END AS wup_id_vz
,AA.gondelkopf_fg AS gk_fg
,AA.TOPARTIKEL_FG AS top_gk_fg
,AA.MINDESTMENGE_BME AS menge_mindestplatzierung_bme
,-111 AS nb_id_vz
,a.dat_angebot_gueltig_von AS dat_von
,a.dat_angebot_gueltig_bis AS dat_bis
,DATEDIFF(DAY, a.dat_angebot_gueltig_von, a.dat_angebot_gueltig_bis)+1 AS anz_tage_werbung
FROM DBP_DATA.ANGEBOT_ART_WUP_ZU_2 aaw
JOIN DBP_DATA.ANGEBOT_2 A
 ON aaw.ANGEBOT_NR = A.ANGEBOT_NR 
AND aaw.mandant_id = A.mandant_id 
AND A.angebot_geloescht_fg = 0
JOIN dbp_view.v_werbewoche_kl_2 ww
ON A.mandant_id = ww.mandant_id
AND A.dat_angebot_gueltig_von = ww.dat
  JOIN dbp_view.v_tag_2 t
         ON a.dat_angebot_gueltig_von = t.dat
JOIN dbp_view.v_ART_GP_WUP_DTS_ZU_PER_2 agw
ON CASE WHEN aaw.mandant_id = 4 THEN 7 ELSE aaw.mandant_id END = agw.mandant_id
AND aaw.art_id = agw.art_id
AND aaw.wup_id = agw.wup_id
AND aaw.nb_id = COALESCE(agw.nb_id, 0)
AND agw.dat_bis='9999-12-31'

LEFT JOIN dbp_view.v_art_gp_nm_zu_per_2 a_gp
ON aaw.art_id = a_gp.art_id
AND aaw.mandant_id = a_gp.mandant_id
AND aaw.wup_id = a_gp.wup_id
AND aaw.nb_id = a_gp.nb_id
AND a_gp.dat_bis='9999-12-31'

LEFT JOIN (
    SELECT mandant_id, angebot_nr,
           MAX(CASE WHEN angebot_attribut_id = 42 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS MINDESTMENGE_BME,
           MAX(CASE WHEN angebot_attribut_id = 49 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS GONDELKOPF_FG,
           MAX(CASE WHEN angebot_attribut_id = 46 THEN TRY_CAST(angebot_attribut_txt AS NUMBER) END) AS TOPARTIKEL_FG
FROM dbp_data.angebot_attribut_zu_2
WHERE angebot_attribut_id BETWEEN 40 AND 53
GROUP BY mandant_id, angebot_nr)AA
ON aaw.angebot_nr = AA.angebot_nr
AND aaw.mandant_id = AA.mandant_id

WHERE aaw.art_id NOT IN (0, -1)  AND loesch_fg=0 
                        AND a.angebot_geloescht_fg=0
                        AND a.angebot_status_id IN (4,6)
                        AND a.transfer_status_id IN (0,3,5,6)
                        AND CASE WHEN a.MANDANT_ID = 7 AND a.ANGEBOT_TYP_CD NOT IN ('ZAI', 'ZAIR', 'ZAIM') THEN 1
                                 WHEN a.MANDANT_ID = 1 AND a.ANGEBOT_TYP_CD NOT IN ('ZAI', 'ZAIR', 'ZAIM')THEN 1
                                 WHEN a.ANGEBOT_TYP_CD NOT IN ('0009', 'ZAI', 'ZAIR', 'ZAIM', '0010', 'ZB09', 'ZB10')THEN 1
                                 ELSE 0 END = 1
                        AND (a.angebot_typ_cd NOT IN ('0005','0006','0007','0008')
                        AND EXISTS (SELECT 1 FROM DBP_VIEW.V_ART_LIST_WUP_ZU_PER_2 V_ART_LIST
                                     WHERE V_ART_LIST.DAT_VON <= a.DAT_ANGEBOT_GUELTIG_VON 
                                     AND V_ART_LIST.DAT_BIS  >= a.DAT_ANGEBOT_GUELTIG_BIS
                                     AND aaw.MANDANT_ID = V_ART_LIST.MANDANT_ID
                                     AND aaw.WUP_ID = V_ART_LIST.WUP_ID
                                     AND aaw.ART_ID = V_ART_LIST.ART_ID) 
                         OR a.angebot_typ_cd IN ('0005','0006','0007','0008'))
)
SELECT DISTINCT
mandant_id,
wup_id,
nb_id,
art_id,
aktion_id,
angebot_id,
dat_von,
dat_bis,
gk_fg,
menge_mindestplatzierung_bme,
top_gk_fg,
0, --fixmenge_wfl_bme,
CURRENT_TIMESTAMP,
CURRENT_TIMESTAMP,
:P_ADJUSTMENT_FG,
0,
NULL,
:P_FAKTOR_REST_VON_NORMALBESTAND,
:P_NACHVERSORGUNG_SCHWELLWERT_PAL_ABRUNDUNG_PROZ,
:P_NACHVERSORGUNG_SCHWELLWERT_PAL_AUFRUNDUNG_PROZ

FROM Angebot_Artikel
--DBP_VIEW.v_wbs_werbeaenderungen_2
        WHERE mandant_id =  :P_MANDANT_ID  
        AND DAT_VON IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_VON, ',')) AS table1 ) 
        AND DAT_BIS IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_DAT_BIS, ',')) AS table1 ) 
        AND ART_ID IN  ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ART_IDS, ',')) AS table1 HAVING LENGTH(table1.value) > 1) 
        AND WUP_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_WUPS, ',')) AS table1 )    
        AND ANGEBOT_ID IN ( SELECT TRIM(table1.value) FROM TABLE(split_to_table(:P_ANGEBOTE, ',')) AS table1 )
        AND NOT (MANDANT_ID, AKTION_ID, ART_ID, DAT_VON, DAT_BIS, ANGEBOT_ID, WUP_ID) IN (SELECT MANDANT_ID, AKTION_ID, ART_ID, DAT_VON, DAT_BIS, ANGEBOT_NR, WUP_ID FROM ART_UPDATE)
        ;

COMMIT;
RETURN 'Artikel_2 gespeichert';

END;
$$;
