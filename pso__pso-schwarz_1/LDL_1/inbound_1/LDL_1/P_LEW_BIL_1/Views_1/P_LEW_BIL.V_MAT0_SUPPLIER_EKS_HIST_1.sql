CREATE OR REPLACE VIEW p_lew_bil.v_mat0_supplier_eks_hist_1
/*****************************************************************************************
#DescStart#
* Jens Thole (c) 05.07.2018
* Erstellung der inneren Auswahl gleichmäßig minimal geschnittener Supplierzeilen.
* Hierzu werden die Minimalschnitte aller zum Supplier_1 gehörigen EKS-Zeilen gesucht und über alle diese zum gleichen
* Supplier_1 gehörigen Zeilen gelegt.
*
* Zusätzlich wird untersucht, ob überhaupt multipel EKS-Nummern zugeordnet wurden. Falls nicht, besteht eine_1 technische
* Restmultiplizität in gleichzeitig gelöscht markierten ehemaligen EKS-Zuordnungen.
* Es findet deshalb ein Ranking statt, welches die Realzuordnung nach oben stellt (relevant_unq_row=1 vor 0) und danach
* nach den dann ja invalidisierten eks-Nummern , so daß auch dann eine_1 Nummer 1 gerankt wird und so
* bei gar keiner Zuordnung dennoch eine_1 leere geliefert wird.
* Der damit gebildete Schalter MAP_TYPE (MULTIPLE|UNIQUE|NOT RELEVANT) wird in der eigentlichen Mat-View benutzt ,
* um die Verarbeitung zu splitten und die aufwendige Listenbildung nur für die Zeilen durchzuführen die dies auch benötigen.
* So kann der Prozeß viel leichtgewichtiger bzgl CPU-LAst aufgebaut werden.
#DescEnd#
*****************************************************************************************/
AS
SELECT  maintab.client_id
      , maintab.sup_sid
      , maintab.eks_no
      , maintab.deleted_fg
        /* Adjusted to make EKS number available also in rows with deleted_fg=1. NSR2331729 */
      , CASE WHEN /*maintab.deleted_fg = 1 OR*/ eks_no = 0 THEN ''
                ELSE TRIM(TO_VARCHAR(maintab.eks_no :: VARCHAR(6)))
        END eks_vc
      , CASE WHEN maintab.deleted_fg = 1 OR maintab.eks_no = 0 THEN 0
                ELSE 1
        END real_fg
      , maintab.dwh_valid_from
      , maintab.dwh_valid_to
      , intvls.dwh_valid_from-1 schnitt_peri_start
      , intvls.dwh_valid_to schnitt_peri_end
      , ROW_NUMBER() OVER (PARTITION BY maintab.client_id
                                      , maintab.sup_sid
                                      , schnitt_peri_start
                                      , schnitt_peri_end
                            ORDER BY real_fg DESC
                                   , eks_no ASC NULLS LAST) relevant_unq_row
      , CASE WHEN SUM(real_fg) OVER (PARTITION BY maintab.client_id
                                                  , maintab.sup_sid
                                                  , schnitt_peri_start
                                                  , schnitt_peri_end) > 1
                THEN 'MULTIPLE'
                WHEN relevant_unq_row=1
                THEN 'UNIQUE'
                ELSE 'NOT RELEVANT'
        END map_type
    FROM p_lew_core_ac.v_supplier_eks_hist_1 maintab
        INNER JOIN (
                    SELECT client_id
                           , sup_sid
                           , dwh_valid_from
                           , COALESCE(MIN(dwh_valid_from) OVER (PARTITION BY client_id, sup_sid ORDER BY dwh_valid_from
                                                                ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)-1
                                      , TO_DATE('30.12.9999', 'DD.MM.YYYy') ) dwh_valid_to
                        FROM (SELECT DISTINCT client_id, sup_sid, dwh_valid_from
                            FROM p_lew_core_ac.v_supplier_eks_hist_1
                            UNION
                            SELECT DISTINCT client_id, sup_sid, dwh_valid_to+1
                            FROM p_lew_core_ac.v_supplier_eks_hist_1
                            ) a
                        WHERE dwh_valid_from<>TO_DATE('99991231', 'yyyymmdd')
                ) intvls
            ON maintab.client_id = intvls.client_id
            AND maintab.sup_sid = intvls.sup_sid
            AND maintab.dwh_valid_from <= intvls.dwh_valid_to
            AND maintab.dwh_valid_to >= intvls.dwh_valid_from;