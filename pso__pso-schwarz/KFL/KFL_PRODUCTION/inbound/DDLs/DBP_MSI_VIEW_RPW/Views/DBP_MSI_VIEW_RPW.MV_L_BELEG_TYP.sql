CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_L_BELEG_TYP
       (
       system_id,
       mandant_id,
       beleg_typ_id
       )
       AS
          SELECT
7,
          mandant_id,
          beleg_typ_id

          FROM dbp_view.v_l_beleg_typ
          WHERE mandant_id = 1;