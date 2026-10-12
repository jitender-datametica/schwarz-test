create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_DISPLAY_1(
	ART_ID,
	MANDANT_ID,
	KL_ART_ID,
	KL_ART_ID_LANG,
	ARTIKELTYP_ID
) as

--2024-10-23, dknop, initial
SELECT
  v01.art_id
, v01.mandant_id
, CASE WHEN v01.kl_art_id = 0 THEN v01.art_id ELSE v01.kl_art_id END AS kl_art_id
, to_varchar(kl_art_id,'FM00000000') AS kl_art_id_lang
, v01.artikeltyp_id

FROM dbp_view.v_art_1 v01

UNION

SELECT
-3 AS art_id
, v01.mandant_id
,-1 AS kl_art_id
,'-1' AS kl_art_id_lang
,-1 AS artikeltyp_id
FROM dbp_view.v_mandant_1 v01;