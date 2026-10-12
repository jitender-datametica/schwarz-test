create or replace dynamic table KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_RPW_DT.MV_RECH_POS_WBNK(
	SYSTEM_ID,
	MANDANT_ID,
	RECH_BELEG_ID,
	GJ,
	RECH_BELEG_POS_ID,
	BETRAG_NETTO,
	BETRAG_BRUTTO,
	WBNK_PLANUNGS_KZ,
	WBNKART_ID,
	ARTHIERTYP_ID,
	WG_ID,
	WUP_ID,
	NB_ID,
	POS_MANUELL_ERSTELLT_FG,
	DAT_BELEG,
	DAT_BUCH,
	DAT_RPW,
	DAT_ERFASST,
	KONTIERUNGSBLOCK_NR
) target_lag = '1 hour, 30 minutes' refresh_mode = FULL initialize = ON_CREATE warehouse = WH_KFL_D_DYNAMIC_TABLE_RPW
 as
-- 10.10.2013 twie: Definiton von P übernommen

                   SELECT
                   7,
                   brd.mandant_id,
                   brd.rech_beleg_id,
                   brd.gj,
                   brd.rech_beleg_pos_id,
                   brd.betrag_beleg,
                   brd.betrag_vk_brutto,
                   CAST('geplant' AS CHAR(20)) AS wbnk_planungs_kz,
                   brd.konditionsart_id AS wbnkart_id,
                   awzp.arthiertyp_id,
                   awzp.wg_id,
                   brd.wup_id,
                   brd.nb_id,
                   brd.pos_manuell_erstellt_fg,
                   br.dat_beleg,
                   br.dat_buch,
                   CASE WHEN br.rech_beleg_status_id = '5' THEN CAST(br.dat_erfasst AS VARCHAR) ELSE NULL END AS dat_rpw_,
                   br.dat_vorerfasst AS dat_erfasst,
                   NULL AS kontierungsblock_nr

                   FROM dbp_view.v_besch_rech_det brd

                   JOIN dbp_view.v_besch_rech br
                   ON brd.mandant_id = br.mandant_id
                   AND brd.rech_beleg_id = br.rech_beleg_id
                   AND brd.gj = br.gj

                   JOIN dbp_view.v_art_wg_zu_per awzp
                   ON  brd.mandant_id      =awzp.mandant_id
                   AND brd.art_id        =awzp.art_id
                   AND brd.arthiertyp_id =awzp.arthiertyp_id
                   AND br.dat_beleg BETWEEN awzp.dat_von AND awzp.dat_bis

                   WHERE  brd.mandant_id = 1
                   AND CONTAINS( konditionsart_id, 'YN')

                   --AND konditionsart_id IN
                   --('YN01','YN02','YN03','YN04','YN05','YN06' ,'YN07','YN08','YN09','YN10','YN11','YN12' ,'YN13','YN14','YN15','YN16','YN17','YN18')

                   UNION ALL

                   SELECT
                   7,
                   brdk.mandant_id,
                   brdk.rech_beleg_id,
                   brdk.gj,
                   brdk.rech_beleg_kont_pos_id AS rech_beleg_pos_id,
                   brdk.betrag_beleg,
                   NULL AS betrag_brutto,
                   CASE WHEN row_grund_id IN ('117','124','125','126','129','133','135') THEN 'statistisch geplant'
                   WHEN row_grund_id IN ('113','127','128','131','136','143','162') THEN 'ungeplant'
                   WHEN row_grund_id IN ('146','150','152','154','163','165','174') THEN 'sonstige Erlöse'
                   WHEN row_grund_id IN ('118','130','137','141','144','145','147','151','153','164','172','173','175') THEN 'Sachkosten'
                   ELSE 'keine BNK'
                   END AS wbnk_planungs_kz,
                   CAST (row_grund_id AS CHAR(4)) AS wbnkart_id,
                   brdk.arthiertyp_id,
                   CASE WHEN brdk.wg_id IS NULL THEN -3 ELSE brdk.wg_id END AS wg_id,
                   br.wup_id,
                   br.nb_id,
                   1 AS pos_manuell_erstellt_fg --Definition gemäß Rücksprache Frau Köhler am 07.08.2006
                   ,
                   br.dat_beleg,
                   br.dat_buch,
                   br.dat_aenderung_rpw AS dat_rpw_,
                   CAST(br.dat_erfasst AS DATE),
                   brdk.kontierungsblock_nr
                   FROM dbp_view.v_besch_rech_det_kont brdk

                   JOIN dbp_view.v_besch_rech br
                   ON br.mandant_id = brdk.mandant_id
                   AND br.rech_beleg_id = brdk.rech_beleg_id
                   AND br.gj = brdk.gj

                   WHERE brdk.mandant_id = 1;
