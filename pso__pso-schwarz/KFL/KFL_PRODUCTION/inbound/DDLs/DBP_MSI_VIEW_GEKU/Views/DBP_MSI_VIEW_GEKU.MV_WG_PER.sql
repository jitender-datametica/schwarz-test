CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_WG_PER
(
    wg_id
   ,arthiertyp_id
   ,lead_mwst_id
   ,dat_von
   ,abt_id
   ,mandant_id
   ,dat_bis
   ,owg_id
)
AS
--22.06.2022 twie: SPEC0145413 Lookup Warengruppe

SELECT

    wg_id
   ,arthiertyp_id
   ,lead_mwst_id
   ,dat_von
   ,abt_id
   ,mandant_id
   ,dat_bis
   ,owg_id

FROM dbp_view.v_wg_per

WHERE arthiertyp_id = 2
AND dat_bis > CURRENT_DATE;