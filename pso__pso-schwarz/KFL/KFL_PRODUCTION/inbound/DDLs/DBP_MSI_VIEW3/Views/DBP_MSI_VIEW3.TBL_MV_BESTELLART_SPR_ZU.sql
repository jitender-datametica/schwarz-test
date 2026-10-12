CREATE OR REPLACE VIEW DBP_MSI_VIEW3.TBL_MV_BESTELLART_SPR_ZU
   AS 
   SELECT
   v01.mandant_id, v01.bestellart_id, v01.spr_id, v01.bestellart_bez

   FROM dbp_view.v_bestellart_spr_zu v01
   UNION

   SELECT
   t01.mandant_id, t01.bestellart_id, t01.spr_id, t01.bestellart_bez
   FROM
   ( --t01
   SELECT v01.mandant_id, v02.spr_id, '-1' AS bestellart_id, 'unbekannte Bestellart' AS bestellart_bez
   FROM dbp_view.v_mandant v01
   CROSS JOIN dbp_view.v_mandant_spr_zu v02
   GROUP BY 1,2,3,4
   ) t01;