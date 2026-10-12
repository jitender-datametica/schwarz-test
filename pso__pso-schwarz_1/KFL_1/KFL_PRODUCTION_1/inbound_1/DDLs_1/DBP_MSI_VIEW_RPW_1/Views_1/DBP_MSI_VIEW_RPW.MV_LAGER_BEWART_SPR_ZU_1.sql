CREATE OR REPLACE VIEW DBP_MSI_VIEW_RPW.MV_LAGER_BEWART_SPR_ZU_1
                   (
                   mandant_id
                   , lager_bewart_id
                   , spr_id
                   , lager_bewart_bez
                   , system_id
                   )
                   AS
                      SELECT
                      v01.mandant_id,
                      v01.lager_bewart_id,
                      v01.spr_id,
                      v01.lager_bewart_bez,
                      7 AS system_id
FROM dbp_view.v_lager_bewart_spr_zu_1 v01

                      WHERE v01.mandant_id = 1
                      AND v01.spr_id = 22
                      --keine Berücksichtigung der SAP-Industriesysteme für DE + CZ
                      AND v01.system_id NOT IN (2,17,28,32,48,53);