CREATE OR REPLACE VIEW DBP_VIEW.V_ANGEBOT (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,angebot_nr                               COMMENT 'Numerische oder Alphanumerische Nummer des Angebots'
  ,dat_angebot_gueltig_von                  COMMENT 'Datum, ab dem das Angebot gültig ist.'
  ,dat_angebot_gueltig_bis                  COMMENT 'Datum bis dahin das Angebot gültig ist'
  ,kjwo_ww                                  COMMENT 'Werbewoche im  Format JJJJWW.'
  ,angebot_name                             COMMENT 'Name des Angebotes'
  ,angebot_beschreibung_txt                 COMMENT 'Freitext zur weiteren beschreibung des Angebotes'
  ,angebot_status_id                        COMMENT 'ID des Angebotsstatus'
  ,angebot_typ_cd                           COMMENT 'Alphanumerischer Code des Angebotstyp.'
  ,anz_angebot_limit                        COMMENT 'Anzahl wie oft das Angebot maximal verwendet werden kann.'
  ,geschaeftsvorfall_id                     COMMENT 'Eindeutige ID eines Geschäftsvorfalls aus gv_id, z.Bsp. 01'
  ,hauptangebot_fg                          COMMENT 'Flag gibt an, ob es sich bei dem Angebot um das Hauptangebot handelt (1) oder nicht (0). Wird ein Artikel in den Märkten zu unterschiedlichen Aktionspreisen angeboten, werden die unterschiedlichen Anegbote einem Hauptangebot  zugeordnet.'
  ,hauptangebot_nr                          COMMENT 'Numerische oder Alphanumerische Nummer des dazugehörigen Hauptangebotes.'
  ,bonuskauf_fg                             COMMENT 'Flag gibt an, ob es sich um einen Bonuskauf handelt (1) oder nicht (0).'
  ,bonuskauf_id                             COMMENT 'Handelt es sich bei dem Angebot um einen Bonuskauf, eindeutige ID einer Bonuskaufaktion z.Bsp. 700 aus bbynr'
  ,konditionsart_id                         COMMENT 'Handelt es sich bei dem Angebot um einen Bonuskauf, Eindeutiger Fachschlüssel der Konditionsart des Bonuskaufes.'
  ,aktion_id                                COMMENT 'Handelt es sich bei dem Angebot um eine Aktion, eindeutige Kennung einer Aktion'
  ,bewart_id                                COMMENT 'Bewegungsart ID. Bewegungsarten > 1000 beziehen sich auf Warenausgang, < 1000 auf Wareneingang'
  ,aktion_typ_id                            COMMENT 'Handelt es sich bei dem Angebot um eine Aktion gibt der Typ die Art der Aktion an: KDN = Promotion erhaltbar wenn App verwendet wird; KDP = Promotion nur für einen gezielten Nutzerkreis erhaltbar (bspw. personalisiert); KDI = Promotion die bei einem externen Partner erworben wurde (bspw.Partner Coupon, SMP Coupon, Gutschein von Partner.'
  ,markt_version_txt                        COMMENT 'Kodierte Information in Textform die aus einem generischen Namen, Länderkürzel und Zeitstempel an dem es angelegt wurde besteht.'
  ,anz_market_version                       COMMENT 'Anzahl gibt an, in wie vielen Märkten das Angebot mit dieser market_version verwendet wird.'
  ,transfer_status_id                       COMMENT 'ID des Transferstatus. Der Transferstatus gibt den aktuellen Stand der Übertragung an SAP Retail an, bspw. "empfohlen", "genehmigt", "storniert", etc.'
  ,akzeptiert_fg                            COMMENT 'Flag gibt an, ob das Angebot akzeptiert ist. Akzeptiert bedeutet, dass es an SAP RET übertragen wird. (Vereinzelt Ausnahmen bei Bonuskauf möglich).'
  ,angebot_geloescht_fg                     COMMENT 'Flag gibt an, ob das Angebot im Quellsystem gelöscht wurde.'
)
COMMENT = 'Stammtabelle für Angebote. Ein Angebot wird in den unterschiedlichen Werbekanälen beworben und in den Märkten für unterschiedliche Artikel umgesetzt.'
 AS 
    SELECT 
        mandant_id,
        angebot_nr,
        dat_angebot_gueltig_von,
        dat_angebot_gueltig_bis,
        kjwo_ww,
        angebot_name,
        angebot_beschreibung_txt,
        angebot_status_id,
        angebot_typ_cd,
        anz_angebot_limit,
        geschaeftsvorfall_id,
        hauptangebot_fg,
        hauptangebot_nr,
        bonuskauf_fg,
        bonuskauf_id,
        konditionsart_id,
        aktion_id,
        bewart_id,
        aktion_typ_id,
        markt_version_txt,
        anz_market_version,
        transfer_status_id,
        akzeptiert_fg,
        angebot_geloescht_fg

FROM DBP_DATA.ANGEBOT ;