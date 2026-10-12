CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ART_MUTTER_WB_1(
	MANDANT_ID,
	ART_ID,
	ART_MUTTER_WB_ID,
	ART_MUTTER_DISPLAY_ID,
	MWB_BASISMENGE_EINH_ID,
	MWB_VERPART_ID,
	ART_MUTTER_WB_NR,
	ART_MUTTER_WB_BEZ,
	ART_MUTTER_WB_FG,
	ART_MUTTER_SAISON_ID,
	POSTEN_ID,
	ART_MUTTER_POSTEN_FG,
	POSTEN_FG,
	ART_MUTTER_BEZUGSWEG
)
AS
--20240131 dknop: AP0197132 SPEC0224688 -> new definition for posten_fg, adding art_mutter_posten_fg
   SELECT
   a.mandant_id
   , a.art_id
   , COALESCE(a.mutter_wb_id,a.art_id) AS art_mutter_wb_id
   -- Ebene Mutter-Artikel_1
   --20200129 nwag2310: extension of display_id with artikeltyp 12 (also implies art_id is a display)
   , CASE WHEN mwb.artikeltyp_id = 12 THEN  mwb.artikeltyp_id ELSE mwb.display_id END AS art_mutter_display_id
   , mwb.basismenge_einh_id AS mwb_basismenge_einh_id
   , COALESCE(mwb.verpart_id,' ')  AS mwb_verpart_id
   , TO_VARCHAR((CASE WHEN a.mandant_id = 1 THEN (COALESCE(a.mutter_wb_id,a.art_id)/100) ELSE (COALESCE(a.mutter_wb_id,a.art_id)/10) END), 'FM00000000')  AS art_mutter_wb_nr -- formatierte Mutter-Artikelnr.
   , msz.art_bez AS art_mutter_wb_bez
   , CASE WHEN a.mutter_wb_id  IS NULL THEN 0 ELSE 1 END::BYTEINT AS art_mutter_wb_fg -- Kennzeichnung Mutterelement
   , mwb.saison_id AS art_mutter_saison_id
   , mwb.posten_id -- Kennzeichnung von Posten
   ,CASE WHEN mwb.posten_kz_sap <> '' THEN 1 ELSE 0 END AS art_mutter_posten_fg
   ,CASE WHEN a.posten_kz_sap <> '' THEN 1 ELSE 0 END AS posten_fg
   /*, CASE
   WHEN SUBSTR( art_mutter_wb_bez, 1, 2) = 'W.'  THEN 1 --WHEN art_mutter_wb_bez LIKE 'W.%'  THEN 1
   WHEN SUBSTR( art_mutter_wb_bez, 1, 3) = 'IW.' THEN 1 --WHEN art_mutter_wb_bez LIKE 'IW.%' THEN 1
   WHEN SUBSTR( art_mutter_wb_bez, LENGTH( art_mutter_wb_bez) - 1) = '/P'  THEN 1 --WHEN art_mutter_wb_bez LIKE '%/P'  THEN 1
   WHEN mwb.posten_id = '1' THEN 1
   ELSE 0
   END::BYTEINT AS posten_fg*/
   , COALESCE(bzw.art_mutter_bezugsweg,4) AS art_mutter_bezugsweg
   FROM dbp_view.v_art_1 a
   JOIN dbp_view.v_art_spr_zu_1  msz
   ON msz.mandant_id = a.mandant_id AND msz.art_id = COALESCE(a.mutter_wb_id,a.art_id)
   AND msz.spr_id = 22
   JOIN dbp_view.v_art_1  mwb
   ON mwb.mandant_id = a.mandant_id AND mwb.art_id = COALESCE(a.mutter_wb_id,a.art_id)
   AND mwb.dat_bis = '9999-12-31'
   --20200420 nwag2310: making bezugsweg for 1 product unique within 1 mandant_1 -> if >=1 store is supplied from DC, product is considered CENTRAL.
   --20200507 nwag2310: switching bezugsweg to MARC_1 as source
   LEFT JOIN ( SELECT mandant_id, art_mutter_id, CASE WHEN anzahl_markt_bezugsweg4 > 0 THEN 4 ELSE 1 END AS art_mutter_bezugsweg
   FROM (
   SELECT
   mandant_id,
   art_id AS art_mutter_id,
   SUM(CASE WHEN bezugsweg_id = 4 THEN 1 ELSE 0 END ) AS anzahl_markt_bezugsweg4
   FROM dbp_view.v_art_wup_status_per_1
   WHERE dat_bis = '9999-12-31' AND (mandant_id, wup_id, art_id) IN (SELECT mandant_id, wup_id, art_id FROM dbp_view.v_art_list_wup_zu_per_1 WHERE nb_id=0 AND dat_bis >= CURRENT_DATE-30 GROUP BY 1,2,3)
   GROUP BY 1,2 ) t0  ) bzw
   ON a.mandant_id=bzw.mandant_id AND COALESCE(a.mutter_wb_id,a.art_id) = bzw.art_mutter_id
;
   