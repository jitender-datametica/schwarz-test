CREATE OR REPLACE VIEW  DBP_MSI_VIEW2.MV_TS_AIS_DE_PROGNOSE_AVQ_EK_SAISON_1 AS
WITH t_rank AS 
(SELECT DISTINCT mandant_id,
    ek_saison_id,
    DAT_GUELTIG_VON,
    DAT_GUELTIG_BIS,
    DENSE_RANK() OVER (PARTITION BY ek_saison_id ORDER BY DAT_GUELTIG_VON DESC) AS abfolge
    FROM DBP_MSI_VIEW2.TS_AIS_DE_EK_SAISON_ART_ZU_1)
, t_akt_zeitraum AS (
SELECT mandant_id,  ek_saison_id,
    DAT_GUELTIG_VON,
    DAT_GUELTIG_BIS
FROM t_rank
WHERE abfolge = 1
)
SELECT v01.mandant_id,
    v01.ek_saison_id,
    v01.DAT_GUELTIG_VON AS DAT_VON,
    v01.DAT_GUELTIG_BIS AS DAT_BIS ,
    v02.dat, 
    COALESCE(v03.menge_absatz_prognose,0) AS saison_menge_absatz_prognose,
    COALESCE(FIRST_VALUE(CASE WHEN v02.akt_tag <= 0 THEN v03.menge_absatz_prognose ELSE 0 END) IGNORE NULLS OVER (PARTITION BY v01.ek_saison_id ORDER BY CASE WHEN v02.akt_tag <= 0 THEN 1 ELSE 10 END, v02.akt_tag DESC),0) AS saison_menge_absatz_prognose_akt_tag_0
FROM t_akt_zeitraum v01 -- ZEitraum pro Aktuelles Cluster 
JOIN dbp_view.v_tag_1 v02
ON v02.dat BETWEEN v01.DAT_GUELTIG_VON AND v01.DAT_GUELTIG_BIS
LEFT JOIN DBP_MSI_VIEW2.TS_AIS_DE_PROGNOSE_AVQ_EK_SAISON_TAG_1 v03
ON v01.mandant_id = v03.mandant_id
AND v01.ek_saison_id = v03.ek_saison_id 
AND v02.dat = v03.dat_prognose

;