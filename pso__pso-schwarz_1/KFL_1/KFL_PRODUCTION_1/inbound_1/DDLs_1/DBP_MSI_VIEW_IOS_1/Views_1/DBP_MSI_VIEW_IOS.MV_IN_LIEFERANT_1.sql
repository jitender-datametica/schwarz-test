CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_IN_LIEFERANT_1 (
   in_lief_id,
   mandant_id,
   IN_LIEF_NR,
   lief_name_1,
   lief_name_2
) AS
SELECT
   v01.in_lief_id,
   v01.mandant_id,
   -- Pruefen, ob Lief_NR eine_1 Nummer ist 
   -- Lieferantennummer besteht nicht immer aus Zahlen 
   case
      when try_to_numeric (v01.IN_LIEF_NR) is null 
      -- Wenn keine Nummer, dann Lieferantennummer so uebernehmen
      then v01.IN_LIEF_NR
      -- wenn eine_1 Nummer, dann fuehrende Nullen entfernen. 
      -- zuerst in eine_1 Nummer umwandeln, dadurch fallen die fuehrende Nullen weg 
      -- und dann wieder als Varchar umwandeln, damit der Datentyp uebereinstimmt.
      else CAST(CAST(v01.IN_LIEF_NR AS Number) AS VARCHAR(10))
   end IN_LIEF_NR,
   v01.lief_name_1,
   v01.lief_name_2
FROM
   dbp_view.v_in_lieferant_1 v01;