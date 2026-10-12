CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_WEWA_GRP_1 (
    wewa_gruppe_id
    ,vorgangsart_id
    ,open_fg
    ,gemeldet_fg
    ,teilgebucht_fg
    ,wewa_grp_bez
    )
    AS
       SELECT
       v.wewa_gruppe_id,
       v.vorgangsart_id,
       v.open_fg,
       v.gemeldet_fg,
       v.teilgebucht_fg,
       s.wewa_gruppe_bez AS wewa_grp_bez
       FROM dbp_view.v_vorgangsart_wewa_gruppe_zu_1 v
       INNER JOIN dbp_view.v_wewa_gruppe_spr_zu_1 s
       ON v.mandant_id = s.mandant_id AND
       v.wewa_gruppe_id = s.wewa_gruppe_id AND
       s.spr_id = 22

       WHERE v.mandant_id = 1;