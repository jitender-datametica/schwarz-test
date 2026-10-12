CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_INVENTURART_INT_SPR_ZU_2 as
   -- LOOKUP-SPRACHE : Inventurart (INT)
   -- 2017.0620 : Initial, VTC Inventur_2
   -- 2017.0815 : Uebersetzungen/mehrsprachig

   SELECT
   inventurart_int_id, MAX(inventurart_int_bez)    AS inventurart_int_bez, MAX(inventurart_int_bez_de) AS inventurart_int_bez_de, MAX(inventurart_int_bez_cz) AS inventurart_int_bez_cz, MAX(inventurart_int_bez_sk) AS inventurart_int_bez_sk, MAX(inventurart_int_bez_hr) AS inventurart_int_bez_hr, MAX(inventurart_int_bez_pl) AS inventurart_int_bez_pl, MAX(inventurart_int_bez_ro) AS inventurart_int_bez_ro, MAX(inventurart_int_bez_bg) AS inventurart_int_bez_bg
   FROM
   (
   SELECT
   ias.inventurart_int_id, CASE WHEN ias.spr_id=22  THEN ias.inventurart_int_bez END AS inventurart_int_bez, CASE WHEN ias.spr_id=22  THEN ias.inventurart_int_bez END AS inventurart_int_bez_de, CASE WHEN ias.spr_id=124 THEN ias.inventurart_int_bez END AS inventurart_int_bez_cz, CASE WHEN ias.spr_id=108 THEN ias.inventurart_int_bez END AS inventurart_int_bez_sk, CASE WHEN ias.spr_id=65  THEN ias.inventurart_int_bez END AS inventurart_int_bez_hr, CASE WHEN ias.spr_id=90  THEN ias.inventurart_int_bez END AS inventurart_int_bez_pl, CASE WHEN ias.spr_id=95  THEN ias.inventurart_int_bez END AS inventurart_int_bez_ro, CASE WHEN ias.spr_id=18  THEN ias.inventurart_int_bez END AS inventurart_int_bez_bg
   FROM dbp_view.v_inventurart_int_spr_zu_2 ias
   ) sub01
   GROUP BY inventurart_int_id
;