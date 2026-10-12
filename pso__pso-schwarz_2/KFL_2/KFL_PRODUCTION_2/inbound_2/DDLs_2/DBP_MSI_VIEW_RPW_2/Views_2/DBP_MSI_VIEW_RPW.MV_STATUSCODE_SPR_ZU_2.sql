CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_STATUSCODE_SPR_ZU_2
       (
       mandant_id
       ,statuscode_id
       ,spr_id
       ,statuscode_bez
       ,statuscode_bez_kurz
       ,statuscode_bez_lang
       ,system_id
       )
       AS
          SELECT
          mandant_id,
          statuscode_id,
          spr_id,
          statuscode_bez,
          statuscode_bez_kurz,
          statuscode_bez_lang,
          7
          FROM dbp_view.v_statuscode_spr_zu_2
          WHERE mandant_id = 1
          AND spr_id = 22
 ;