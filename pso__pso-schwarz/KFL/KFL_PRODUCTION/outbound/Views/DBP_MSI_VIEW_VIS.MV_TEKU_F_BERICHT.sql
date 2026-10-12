CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_teku_f_bericht (teku_bericht_id, dat_besuchs_beginn,
zeit_besuchs_beginn, dat_besuchs_ende, zeit_besuchs_ende, mandant_id, wup_id, teku_checkliste_id, frische_fg,
einsatzzeit) AS SELECT TB.teku_bericht_id,
 TB.dat_besuchs_beginn,
 TB.zeit_besuchs_beginn,
 TB.dat_besuchs_ende,
 TB.zeit_besuchs_ende,
 TB.mandant_id,
 TB.wup_id,
 TC.teku_checkliste_id,
 TC.frische_fg,
 DATETIME_DIFF(CAST(REPLACE(CAST(TB.dat_besuchs_ende AS STRING) || ' ' || CAST(TB.zeit_besuchs_ende AS STRING), ',', ':') AS DATETIME)
  ,CAST(REPLACE(CAST(TB.dat_besuchs_beginn AS STRING) || ' ' || CAST(TB.zeit_besuchs_beginn AS STRING), ',', ':') AS
   DATETIME), SECOND) AS einsatzzeit
FROM kfl_production_dbp_view.v_teku_bericht_per AS TB
 INNER JOIN kfl_production_dbp_view.v_l_teku_checkliste AS TC ON TB.teku_checkliste_id = TC.teku_checkliste_id
WHERE TB.dat_bis = DATE '9999-12-31'
 AND TB.loeschung_fg = 0
 AND TB.nicht_auswerten_fg = 0;