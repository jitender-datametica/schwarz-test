CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_L_IN_ART_WUP_STATUS_1 as
      SELECT
      v01.mandant_id,
      v02.werk_id,
      v01.in_art_id,
      COALESCE(v03.einkaeufer_grp_id, '-1') AS einkaeufer_grp_id

      FROM dbp_view.v_in_art_1 v01
      INNER JOIN dbp_view.v_in_werk_1 v02
      ON v01.mandant_id = v02.mandant_id
      LEFT OUTER JOIN dbp_view.v_in_art_wup_status_1 v03
      ON
      v01.in_art_id     = v03.in_art_id AND
      v01.mandant_id =  v03.mandant_id AND
      v02.werk_id =v03.werk_id;