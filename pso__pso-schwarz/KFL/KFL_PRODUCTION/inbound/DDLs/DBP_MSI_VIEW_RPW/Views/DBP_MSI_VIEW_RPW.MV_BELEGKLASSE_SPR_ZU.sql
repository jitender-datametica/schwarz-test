CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEGKLASSE_SPR_ZU
    (
      mandant_id
      ,belegklasse_id
      ,spr_id
      ,belegklasse_bez
      ,belegklasse_bez_kurz
      ,belegklasse_bez_lang
      ,system_id
    )
    AS
       SELECT
         mandant_id,
       belegklasse_id,
       spr_id,
       belegklasse_bez,
       belegklasse_bez_kurz,
       belegklasse_bez_lang,
       7
       FROM dbp_view.v_belegklasse_spr_zu
       WHERE mandant_id = 1
         AND spr_id = 22
 ;