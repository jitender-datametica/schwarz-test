CREATE OR REPLACE VIEW DBP_VIEW.V_TMS_GP_BESCHRAENKUNG_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_gp_id                                COMMENT 'ID des Geschäftspartners (Kundennummer). Aus plkd.nr'
  ,tms_gp_typ_cd                            COMMENT 'Geschäftspartnertyp. L = Lager, S = Spediteur, 0(null) = Markt(Kunde)'
  ,tms_beschraenkung_id                     COMMENT 'Geschäftspartner-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'
  ,tms_beschraenkung_pos_nr                 COMMENT 'Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. bes1 = 1, bes2 = 2, …'
)
COMMENT = 'TMS - Zuordnungstabelle für Geschäftspartner mit Einschränkungen, um die für den Geschäftspartner geltenden Einschränkungen zu definieren. Aus der Quelle plkd (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_gp_id,
        tms_gp_typ_cd,
        tms_beschraenkung_id,
        tms_beschraenkung_pos_nr

FROM DBP_DATA.TMS_GP_BESCHRAENKUNG_ZU_2 ;