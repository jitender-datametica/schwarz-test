CREATE TABLE DBP_DATA.TS_WBS_ARTIKEL_VZ_SHARE (
   mandant_id                          NUMBER(38,0)    NOT NULL COMMENT 'Mandant',
   art_id                              NUMBER(38,0)    NOT NULL COMMENT 'Artikelnummer',
   aktion_id                           VARCHAR(10)     NOT NULL COMMENT 'Aktionsnummer',
   angebot_id                          NUMBER(38,0)    NOT NULL COMMENT 'aus TableName wbs_werbeaenderungen Offer/Angebot',
   kjwo                                NUMBER(38,0)    NOT NULL COMMENT 'Kalenderwoche Aktionsstart',
   ausliefergruppe_id                  VARCHAR(10)     NOT NULL COMMENT 'Ausliefergruppe',
   gp_id                               NUMBER(38,0)    NOT NULL COMMENT 'Lieferantenummer aus lifnr. , Kontonummer des Lieferanten bzw. Kreditors',
   wup_id_vz                           NUMBER(38,0)    NOT NULL COMMENT 'Verteilzentrum',
   nb_id_vz                            NUMBER(38,0)    NOT NULL COMMENT 'Nebenbetrieb VZ',
   mandant_id_vz                       NUMBER(38,0)    NOT NULL COMMENT 'Mandant VZ',
   rank_share                          NUMBER(38,0)    COMMENT 'Rank (Position des Shares)',
   share_wert                          NUMBER(38,0)    COMMENT 'Share (Wert des Shares)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = ' Settings for WBS calculation core on product level / content maintained by transaction services document';
