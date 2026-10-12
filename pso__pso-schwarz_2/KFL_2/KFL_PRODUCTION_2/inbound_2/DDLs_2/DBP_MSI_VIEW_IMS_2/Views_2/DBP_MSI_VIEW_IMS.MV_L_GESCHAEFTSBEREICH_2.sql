CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_GESCHAEFTSBEREICH_2 AS
-- 17.05.2013 twie: Lookup für Geschäftsbereich

   SELECT
   geschaeftsbereich_id,
   mandant_id

   FROM dbp_view.v_l_geschaeftsbereich_2;