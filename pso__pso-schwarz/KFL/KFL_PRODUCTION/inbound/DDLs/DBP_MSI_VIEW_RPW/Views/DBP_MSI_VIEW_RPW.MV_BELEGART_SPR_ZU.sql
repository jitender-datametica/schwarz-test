CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_BELEGART_SPR_ZU
          (
            mandant_id
            ,belegart_id
            ,spr_id
            ,belegart_bez
            ,system_id
          )
          --INC INC5341249 Hard-coded system_id ersetzen durch Spaltenbezug
          AS
             SELECT
             mandant_id,
             belegart_id,
             spr_id,
             belegart_bez,
             system_id
             FROM dbp_view.v_belegart_spr_zu
             WHERE mandant_id = 1
             AND spr_id = 22
 ;