create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_WBS_REFERENZARTIKEL_1(
	MANDANT_ID,
	ART_ID,
	REF_ART_ID,
	REF_ANZ_MAERKTE,
	AVG_VK_BRUTTO,
	AVG_REF_VK_BRUTTO,
	REF_SCORE_RANG,
	REF_SCORE,
	DIFF_VK,
	DIFF_ABSATZ,
	DIFF_ABSATZ_ABSOLUT,
	DIFF_ABSATZ_KENNZ,
	DIFF_COSINUS,
	DIFF_GEWICHT,
	DIFF_WUG,
	AKTION_ID,
	REF_LTZ_DAT_VON,
	DAT_VON,
	LTZ_DAT_VON,
	BERECHNUNG_TYP,
	DAT_BERECHNUNG,
	SELEKTOR_FG,
	BERECHNUNG_SUBTYP
) as
-- 26.01.2022 richternic: Neu Anlage_1 - Migration AI Cloud
-- 30.03.2022 richternic: Einschränkung auf max dat_berechnung 
WITH MAX_DAT_BERECHNUNG AS (
        Select mandant_id, 
                MAX(dat_berechnung) AS max_dat_berechnung
        FROM DBP_VIEW.V_WBS_REFERENZARTIKEL_1
        GROUP BY mandant_id
)
 SELECT 
        v01.mandant_id
        ,art_id
        ,ref_art_id
        ,ref_anz_maerkte
        ,avg_vk_brutto
        ,avg_ref_vk_brutto
        ,ref_score_rang
        ,ref_score
        ,diff_vk
        ,diff_absatz
        ,diff_absatz_absolut
        ,diff_absatz_kennz
        ,diff_cosinus
        ,diff_gewicht
        ,diff_wug
        ,aktion_id
        ,ref_ltz_dat_von
        ,dat_von
        ,ltz_dat_von
        ,berechnung_typ
        ,dat_berechnung
        ,selektor_fg
        ,berechnung_subtyp
FROM DBP_VIEW.V_WBS_REFERENZARTIKEL_1 v01
JOIN MAX_DAT_BERECHNUNG v02
ON v01.mandant_id = v02.mandant_id
AND v01.dat_berechnung = v02.max_dat_berechnung;