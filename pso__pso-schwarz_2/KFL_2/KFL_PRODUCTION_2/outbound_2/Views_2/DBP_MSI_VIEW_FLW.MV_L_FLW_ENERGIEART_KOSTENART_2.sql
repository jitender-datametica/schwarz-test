CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_energieart_kostenart_2 (zaehlerart, kostenart_energie_id)
AS SELECT TRIM(CASE
   WHEN ka_lv5 = 'K314-31'
   THEN 'wasser_m3 '
   WHEN ka_lv5 = 'K314-32'
   THEN 'gas_m3'
   ELSE 'strom_kwh'
   END) AS zaehlerart,
 ka_lv11 AS kostenart_energie_id
FROM kfl_production_dbp_msi_v_view.v_ka_ka_grp_denorm_2
WHERE ka_lv5 IN ('K314-31', 'K314-32')
 OR ka_lv3 = 'K313';