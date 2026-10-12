CREATE OR REPLACE VIEW DBP_VIEW.V_TP_OBJEKT_ADRESSE_ZU_PER_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen'
  ,tp_objekt_id                             COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2'
  ,werk_id                                  COMMENT 'Numerischer Surrogate key für das Werk'
  ,standort_id                              COMMENT 'ID eines Standorts. Entspricht bei Bestandsmärkten der Marktnummer,  bei zukünftigen Standorten eine_2 Nummer bzw. bei Dummy_2-Standorten XXXX'
  ,tp_objekt_sort_id                        COMMENT 'Equipment - Sortierfeld'
  ,dat_von                                  COMMENT 'Datum (von) - Date when record became valid'
  ,dat_bis                                  COMMENT 'Datum (bis) - Date when record expired, and is no logner valid'
  ,instandhaltung_werk_id                   COMMENT 'Numerischer Surrogate key für das Werk werks. Plant where the equipment should be serviced. e. g. small fork lifters used in the stores are taken to the DCs for maintenance+repairs.'
)
COMMENT = 'Adressdaten zum Equipment aus SAP Industry (Tabelle EQUI_ADDR)'
 AS 
    SELECT 
        mandant_id,
        tp_objekt_id,
        werk_id,
        standort_id,
        tp_objekt_sort_id,
        dat_von,
        dat_bis,
        instandhaltung_werk_id

FROM DBP_DATA.TP_OBJEKT_ADRESSE_ZU_PER_2 ;