CREATE OR REPLACE VIEW dbp_view.v_flw_rauchverlust
 AS
 SELECT
    mandant_id
   ,werk_id
   ,dat_rauchvorgang
   ,zeit_rauchvorgang
   ,flw_art_id
   ,flw_arbeitsplatz1_id
   ,transport_einheit_id
   ,flw_tenum_rauchprozess_kennzeichen
   ,rauchwagen_id
   ,nettogew_in
   ,nettogew_out
   ,basismenge_einh_id
   ,nettogew_diff_in_out
 FROM dbp_data.flw_rauchverlust;