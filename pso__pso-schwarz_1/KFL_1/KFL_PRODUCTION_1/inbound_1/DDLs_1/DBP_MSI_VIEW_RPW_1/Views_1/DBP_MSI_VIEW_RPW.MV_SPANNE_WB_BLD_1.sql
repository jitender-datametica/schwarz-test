CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_SPANNE_WB_BLD_1(
	DAT,
	BELEG_WB_ID,
	BELEG_WB_POS_ID,
	MANDANT_ID,
	SYSTEM_ID,
	ABS_ID,
	RCV_ID,
	ART_ID,
	BEW_ART_WB_ID,
	BELASTUNGSART_ID,
	BELASTUNGSART_VD_ID,
	VK_BRUTTO,
	EK_NETTO,
	MWST,
	MWST_ID,
	SPANNE_WB_HERKUNFT_ID,
	MENGE
) AS
-- 19.07.2023 twie: SPEC0064436 belastungsart hinzu

       SELECT
       bf.dat_lagerbew_ist AS dat_,
       bfd.lief_beleg_id,
       bfd.lief_beleg_pos_id,
       bfd.mandant_id,
       7 AS system_id,
       CASE
       WHEN merker = 1
       THEN bfd.wup_id
       ELSE CAST(bf.auftraggeber_id AS INTEGER)
       END As abs_id,
       CASE
       WHEN merker = 1
       THEN CAST(bf.auftraggeber_id AS INTEGER)
       ELSE bfd.wup_id
       END As rcv_id,
       bfd.art_id,
       bf.lief_typ_id,  
       bf.lief_typ_id, -- belastungsart_id
       1 AS belastungsart_vd_id,-- verdichtet Belastungsart_id 
       CAST(
       CASE
       WHEN merker = 1
       THEN COALESCE((zekp.ek_netto * zekp.komponentenmenge), (zekp_gp.ek_netto * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme
       ELSE COALESCE((zekp.ek_netto * zekp.komponentenmenge), (zekp_gp.ek_netto * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme * (-1)
       END
       AS DECIMAL(18,3)) AS ek_netto,
       CAST(
       CASE
       WHEN merker = 1
       THEN COALESCE((zekp.ek_netto_bnk * zekp.komponentenmenge), (zekp_gp.ek_netto_bnk * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme
       ELSE COALESCE((zekp.ek_netto_bnk * zekp.komponentenmenge), (zekp_gp.ek_netto_bnk * zekp_gp.komponentenmenge)) * bfd.menge_lief_ist_lme* (-1)
       END
       AS DECIMAL(18,3)) AS ek_netto_bnk,
       mp.mwst AS mwst,
       mp.mwst_id AS mwst_id,
       1 AS spanne_wb_herkunft_id,
       CASE
       WHEN merker = 1
       THEN bfd.menge_lief_ist_lme
       ELSE bfd.menge_lief_ist_lme   * (-1.0)
       END AS menge
       
       FROM dbp_view.v_besch_lief_det_1 bfd

       JOIN
       (
       SELECT 1 AS merker
       FROM dbp_view.v_spr_1
       WHERE spr_id = 22
       UNION ALL
       SELECT 2 AS merker
       FROM dbp_view.v_spr_1
       WHERE spr_id = 22
       ) AS test_1
       ON 1 = 1

       JOIN dbp_view.v_besch_lief_1 bf
       ON bf.lief_beleg_id = bfd.lief_beleg_id
       AND bf.mandant_id = bfd.mandant_id
       AND bf.dat_lief_soll  = bfd.dat_lief_soll
       AND bf.lief_typ_id = 'YU'

       JOIN dbp_view.v_art_1 a
       ON a.art_id = bfd.art_id
       AND a.mandant_id = bfd.mandant_id

       JOIN dbp_view.v_mwst_per_1 mp
       ON mp.mwst_id = a.mwst_id
       AND mp.mandant_id = a.mandant_id
       AND bf.dat_lagerbew_ist BETWEEN mp.dat_von
       AND mp.dat_bis

       JOIN dbp_view.v_art_gp_zu_per_1 agz
       ON agz.art_id = bfd.art_id
       AND agz.mandant_id = bfd.mandant_id
       AND bf.dat_lief_soll BETWEEN agz.dat_von
       AND agz.dat_bis
       LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_1  zekp_1
       ON    zekp.art_id = bfd.art_id
       AND zekp.mandant_id = bfd.mandant_id
       AND zekp.gp_id = agz.gp_id
       AND (
       CASE
       WHEN bfd.nb_id = -111 THEN bfd.wup_id
       ELSE -1 END) = zekp.wup_id
       AND (
       CASE
       WHEN bfd.nb_id = -111 THEN bfd.nb_id
       ELSE -1 END)  = COALESCE(zekp.nb_id,-1)
       AND bf.dat_lagerbew_ist BETWEEN zekp.dat_von
       AND zekp.dat_bis
       LEFT OUTER JOIN dbp_view.v_art_gp_wup_zu_per_1  zekp_gp
       ON    zekp_gp.art_id = bfd.art_id
       AND zekp_gp.mandant_id = bfd.mandant_id
       AND zekp_gp.gp_id <> agz.gp_id
       AND (
       CASE
       WHEN bfd.nb_id = -111 THEN bfd.wup_id
       ELSE -1 END) = zekp_gp.wup_id
       AND (
       CASE
       WHEN bfd.nb_id = -111 THEN bfd.nb_id
       ELSE -1 END)  = COALESCE(zekp_gp.nb_id,-1)
       AND bf.dat_lagerbew_ist BETWEEN zekp_gp.dat_von
       AND zekp_gp.dat_bis

       WHERE bfd.mandant_id = 1;