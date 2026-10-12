CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_AIS_INT.MV_BEST_AUSG_MENGE_EINH_2
(
 mandant_id
,art_id
,best_menge_einh_id
,best_umrech_faktor
,best_menge_einh_inhalt
,ausg_menge_einh_id
,ausg_umrech_faktor
,ausg_menge_einh_inhalt
,einh_bez_kaufm
) TARGET_LAG = '1 hour, 30 minutes' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_INT
AS
SELECT
 v01.mandant_id
,v01.art_id
,CAST(CASE WHEN v01.best_menge_einh_id IS NULL OR v01.best_menge_einh_id='' THEN 'ST' ELSE best_menge_einh_id END AS CHAR(3)) AS best_menge_einh_id
,COALESCE(CASE WHEN v02.umrech_faktor = 0 THEN NULL ELSE v02.umrech_faktor END, 1) AS best_umrech_faktor
,CAST((1 / best_umrech_faktor) AS DECIMAL(18,0)) AS best_menge_einh_inhalt
,CAST(CASE WHEN v03.ausg_menge_einh_id IS NULL OR v03.ausg_menge_einh_id='' THEN 'ST' ELSE ausg_menge_einh_id END AS CHAR(3)) AS ausg_menge_einh_id
,COALESCE(CASE WHEN v04.umrech_faktor = 0 THEN NULL ELSE v04.umrech_faktor END, 1) AS ausg_umrech_faktor
,CAST((1 / ausg_umrech_faktor) AS DECIMAL(18,0)) AS ausg_menge_einh_inhalt
,v05.einh_bez_kaufm
FROM dbp_view.v_art_2 v01
LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.art_id = v02.art_id
AND v01.best_menge_einh_id = v02.altnv_menge_einh_id
AND v02.dat_bis = '9999-12-31'
LEFT OUTER JOIN dbp_view.v_art_vorschlagswert_per_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.art_id = v03.art_id
AND v03.dat_bis = '9999-12-31'
LEFT OUTER JOIN dbp_view.v_art_umrechnung_faktor_per_2 v04
ON v03.mandant_id = v04.mandant_id
AND v03.art_id = v04.art_id
AND v03.ausg_menge_einh_id = v04.altnv_menge_einh_id
AND v04.dat_bis = '9999-12-31'
-- 08.04.2022 sschuecke / NSR2831167 Erweiterung um Join auf dbp_data.einh_spr_zu_2, um MSI Schema korrigieren zu können
LEFT OUTER JOIN dbp_view.v_einh_spr_zu_2 v05
ON v01.best_menge_einh_id = v05.einh_id
AND v03.ausg_menge_einh_id = v05.einh_id
AND v01.mandant_id = v05.mandant_id
AND v05.spr_id = 22;