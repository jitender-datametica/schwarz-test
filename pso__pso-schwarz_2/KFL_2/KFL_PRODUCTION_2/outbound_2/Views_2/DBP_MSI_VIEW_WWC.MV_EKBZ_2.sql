CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_ekbz_2 (mandant_id, belnr, buzei, gjahr, ekbz_bewtp, dmbtr,
kschl, shkko) AS SELECT mandant_id,
 folge_beleg_id AS belnr,
 folge_beleg_pos_id AS buzei,
 kj AS gjahr,
 best_entw_typ_id AS ekbz_bewtp,
   CASE
   WHEN soll_haben_kko = 'S'
   THEN - 1
   ELSE 1
   END * betrag_kondition AS dmbtr,
 konditionsart_id AS kschl,
 soll_haben_kko AS shkko
FROM kfl_production_dbp_view.v_best_belegfluss_bnk_2;