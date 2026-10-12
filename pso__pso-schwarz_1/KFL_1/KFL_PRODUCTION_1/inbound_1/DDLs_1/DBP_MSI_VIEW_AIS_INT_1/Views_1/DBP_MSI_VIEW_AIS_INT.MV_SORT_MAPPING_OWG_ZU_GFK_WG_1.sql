CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_SORT_MAPPING_OWG_ZU_GFK_WG_1
(
	MANDANT_ID,
	GFK_WG_ID,
	MANDANT_ID_GFK_WG,
	GFK_WG_BEZ,
	OWG_ID,
	MANDANT_ID_OWG,
	OWG_BEZ,
	OWG_BEZ_DE,
	OWG_BEZ_CZ,
	OWG_BEZ_SK,
	OWG_BEZ_HR,
	OWG_BEZ_PL,
	OWG_BEZ_RO,
	OWG_BEZ_BG
) AS
   SELECT 
    DISTINCT v02.mandant_id, 
    v03.gfk_wg_id, 
    v03.mandant_id AS mandant_id_gfk_wg, 
    v03.gfk_wg_bez, 
    v04.owg_id, 
    v04.mandant_id AS mandant_id_owg, 
    v04.owg_bez, 
    v04.owg_bez_de, 
    v04.owg_bez_cz, 
    v04.owg_bez_sk, 
    v04.owg_bez_hr, 
    v04.owg_bez_pl, 
    v04.owg_bez_ro, 
    v04.owg_bez_bg
    
   FROM (DBP_DATA.KL_WG_NIELSEN_GFK_HHP_WG_ZU_1 v01
   FULL OUTER JOIN DBP_DATA.GFK_HHP_WG_1 v03
   ON  (v01.mandant_id = v03.mandant_id
   AND  v01.gfk_wg_id  = v03.gfk_wg_id )
   FULL OUTER JOIN DBP_MSI_VIEW_AIS_INT.mv_owg_spr_zu_1 v04
   ON  (v01.mandant_id = v04.mandant_id
   AND  v01.kl_wg_id   = v04.owg_id))
   JOIN DBP_DATA.MANDANT_1 v02
   ON (v02.mandant_id = COALESCE(v01.mandant_id, v03.mandant_id, v04.mandant_id,v02.mandant_id));