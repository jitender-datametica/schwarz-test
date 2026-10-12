CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEG_TYP_SPR_ZU_2
 (
 system_id,
 mandant_id,
 spr_zu,
 beleg_typ_id,
 beleg_typ_bez
 )
 AS
    SELECT
7,
    mandant_id,
    spr_id,
    beleg_typ_id,
    beleg_typ_bez
    FROM dbp_view.v_beleg_typ_spr_zu_2
    WHERE mandant_id = 1;