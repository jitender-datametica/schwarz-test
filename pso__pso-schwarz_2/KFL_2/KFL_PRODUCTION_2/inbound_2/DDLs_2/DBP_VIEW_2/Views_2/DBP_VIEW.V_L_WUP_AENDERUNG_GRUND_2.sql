CREATE OR REPLACE VIEW DBP_VIEW.V_L_WUP_AENDERUNG_GRUND_2 (
   wup_aenderung_grund_id                   COMMENT 'Numerischer Code fuer den Grund der WUP_2 ID Aenderung. Ist gefuellt fuer die wup_id, die die Aenderung erfahren hat, somit bei der aktuellen wup_id standardmaessig 0. Der Aenderungsgrund steht immer in der alten wup_2 ID.
Moegliche Auspraegungen:
0 = keine Aenderung
1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)
2 = Umzug (seit Einfuehrung der Filialumgliederungen)
3 = Umgliederung
4 = Abriss / Neubau'
)
COMMENT = 'Diese Lookup-Tabelle beinhaltet die Gruende fuer Aenderungen der WUP_2 ID.
Moegliche Auspraegungen:
0 = keine Aenderung
1 = Umzug (Historie / vor Einfuehrung der Filialumgliederungen)
2 = Umzug (seit Einfuehrung der Filialumgliederungen)
3 = Umgliederung
4 = Abriss / Neubau'
 AS 
    SELECT 
        wup_aenderung_grund_id

FROM DBP_DATA.L_WUP_AENDERUNG_GRUND_2 ;