CREATE OR REPLACE VIEW DBP_VIEW.V_WUP_AENDERUNG_GRUND_SPR_ZU_1 (
   wup_aenderung_grund_id                   COMMENT 'Numerischer Code fuer den Grund der WUP_1 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_1 ID.
Moegliche Auspraegungen:
0 = keine Aenderung
1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)
2 = Umzug (seit Einfuehrung der Filialumgliederungen)
3 = Umgliederung
4 = Abriss / Neubau'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,wup_aenderung_grund_bez                  COMMENT 'Bezeichnung des Änderungsgrundes der WUP_1 ID in jeweiliger Sprache.'
)
COMMENT = 'Zuordnungstabelle zwischen den Änderungsgrunde der WUP_1 ID und der Sprache. Beinhaltet von der Sprache abhängige Bezeichnungen der Gründe.'
 AS 
    SELECT 
        wup_aenderung_grund_id,
        spr_id,
        wup_aenderung_grund_bez

FROM DBP_DATA.WUP_AENDERUNG_GRUND_SPR_ZU_1 ;