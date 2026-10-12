create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_BESCH_RECH_DET_KONT(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_BELEG_ID,
	RECH_BELEG_KONT_POS_ID,
	GJ,
	KONTIERUNGSBLOCK_NR,
	ROW_GRUND_ID,
	DAT_ROW,
	MENGE,
	BASISMENGE_EINH_ID,
	SAP_MWST_ID,
	ART_ID,
	BETRAG_BELEG,
	DAT_BEZUG,
	WG_ID,
	ARTHIERTYP_ID,
	BUCH_GRUND_INT_ID,
	BUCH_GRUND_EXT_ID,
	MENGE_GP_BEST,
	BETRAG_GP_BEST,
	GP_FEHLERART_ID,
	KORREKTURART_ID,
	BETRAG_GP_FEHLER_NETTO,
	RECH_KONTOART_ID,
	SPERRGRUND_BETRAG_FG,
	WUP_ID,
	NB_ID,
	BETRAG_NETTO,
	RETOURENPOS_FG,
	DAT_RPW,
	DAT_BUCH,
	DAT_BELEG,
	DAT_ERFASST,
	DAT_RECH_EINGANG,
	POS_MANUELL_ERSTELLT_FG
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
          SELECT
          7,
          brd.mandant_id,
          brd.rech_beleg_id,
          brd.rech_beleg_kont_pos_id,
          brd.gj,
          brd.kontierungsblock_nr,
          COALESCE(brd.row_grund_id ,'0') AS row_grund_id,
          brd.dat_row,
          brd.menge,
          brd.basismenge_einh_id,
          brd.sap_mwst_id,
          brd.art_id,
          brd.betrag_beleg,
          brd.dat_bezug,
          CASE WHEN brd.wg_id IS NULL THEN -3 ELSE brd.wg_id END AS wg_id,
          brd.arthiertyp_id,
          COALESCE (brd.buch_grund_int_id, '0') AS buch_grund_int_id,
          COALESCE (brd.buch_grund_ext_id,'0') AS buch_grund_ext_id,
          brd.menge_gp_best,
          brd.betrag_gp_best,
          COALESCE (brd.gp_fehlerart_id,'0') AS gp_fehlerart_id,
          COALESCE (brd.korrekturart_id,'0') AS korrekturart_id,
          brd.betrag_gp_fehler_netto,
          COALESCE (brd.rech_kontoart_id, '0') AS rech_kontoart_id,
          brd.sperrgrund_betrag_fg,
          br.wup_id,
          br.nb_id,
          brd.betrag_netto,
          brd.retourenpos_fg,
          ---CASE WHEN br.rech_beleg_status_id = '5' THEN CAST(br.dat_erfasst AS VARCHAR)  ELSE NULL END AS dat_rpw_,
          CASE WHEN br.rech_beleg_status_id = '5'  THEN TO_DATE(br.dat_erfasst)  ELSE NULL END AS dat_rpw_,
          
          
          
          br.dat_buch,
          br.dat_beleg,
          br.dat_vorerfasst AS dat_erfasst,
          br.dat_rech_eingang,
          1 AS pos_manuell_erstellt_fg
          FROM dbp_view.v_besch_rech_det_kont brd

          JOIN dbp_view.v_besch_rech br
          ON br.mandant_id = brd.mandant_id
          AND br.rech_beleg_id = brd.rech_beleg_id
          AND br.gj = brd.gj

          WHERE brd.mandant_id = 1;
