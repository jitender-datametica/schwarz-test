CREATE OR REPLACE VIEW DBP_MSI_VIEW_IMS.MV_L_IN_LIEFERANT_1
-- 14.06.2013 twie: Erstellung Lookup Lieferant
-- 27.06.2013 twie: Umstellung Tabelle von lief_name auf lief_name_1 und lief_name_2

AS
   SELECT  in_lief_id,
           mandant_id,
           LTRIM( COLLATE(in_lief_nr,''), '0') AS in_lief_nr,
           lief_name_1 || ' ' ||  lief_name_2 AS lief_name
   FROM  dbp_view.v_in_lieferant_1
   ;