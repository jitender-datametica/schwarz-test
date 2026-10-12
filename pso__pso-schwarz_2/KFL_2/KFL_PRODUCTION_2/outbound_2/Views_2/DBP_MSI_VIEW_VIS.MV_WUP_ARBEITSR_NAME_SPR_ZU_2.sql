
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_arbeitsr_name_spr_zu_2 AS SELECT mandant_id,
 tp_arbeitsrecht_name,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_de,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_cz,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_sk,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_hr,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_pl,
 tp_arbeitsrecht_name_trans AS tp_arbeitsrecht_name_bez_ro,
 tp_arbeitsrecht_name_bez AS tp_arbeitsrecht_name_bez_bg
FROM (SELECT DISTINCT mandant_id,
   tp_arbeitsrecht_name,
    CASE
    WHEN tp_arbeitsrecht_name = ' '
    THEN 'nicht zugeordnet'
    ELSE tp_arbeitsrecht_name
    END AS tp_arbeitsrecht_name_bez,
    CASE
    WHEN mandant_id = 8
    THEN kfl_production_dbp_process.transcriptc(CASE
      WHEN tp_arbeitsrecht_name = ' '
      THEN 'nicht zugeordnet'
      ELSE tp_arbeitsrecht_name
      END)
    ELSE CASE
     WHEN tp_arbeitsrecht_name = ' '
     THEN 'nicht zugeordnet'
     ELSE tp_arbeitsrecht_name
     END
    END AS tp_arbeitsrecht_name_trans
  FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per_2
  WHERE dat_bis = DATE '9999-12-31') AS tpe2;