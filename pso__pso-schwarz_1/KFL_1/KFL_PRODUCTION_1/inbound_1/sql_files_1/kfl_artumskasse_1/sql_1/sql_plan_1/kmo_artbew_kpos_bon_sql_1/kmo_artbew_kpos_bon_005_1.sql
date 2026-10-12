--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.artbew_kmo_tmp_1
(       mandant_id,
        wup_id,
        nb_id,
        art_id,
        gp_id,
        einkaufsorganisation_id,
        bewart_id,
        dat,
        aktion_id,
        herst_id,
        mwst_id,
        wrg_1,
        posten_id,
        bezugsweg_id,
        menge,
        umsatz_netto,
        umsatz_mwst_betrag,
        promo_fg,
        ean_kasse,
        --  ,umrechnungskurs 
        diff_umsatz_netto_konz,
        diff_umsatz_mwst_betrag_konz,
        bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby
)
SELECT mandant_id,
       wup_id,
       nb_id,
       art_id,
       gp_id,
       einkaufsorganisation_id,
       bewart_id,
       dat,
       aktion_id,
       herst_id,
       mwst_id,
       wrg_1,
       posten_id,
       bezugsweg_id,
       menge,
       umsatz_netto,
       umsatz_mwst_betrag,
       promo_fg,
       ean_kasse,
       --  ,umrechnungskurs
       diff_umsatz_netto_konz,
       diff_umsatz_mwst_betrag_konz,
       bewart_det_id,
        pv_aktion,
        pv_bby,
        pv_kdn_bby,
        pv_kdp_bby,
        pv_aktion_bby,
        pv_aktion_kdn_bby,
        pv_aktion_kdp_bby
FROM   (SELECT l.mandant_id AS mandant_id,
               l.wup_id AS wup_id,
               lkp_nb_id AS nb_id,
               lkp_art_id AS art_id,
               -1 AS gp_id,
               -1 AS einkaufsorganisation_id,
               CASE WHEN l.mandant_id IN ( 4 )
                      --bartosiewiczadm - cloud migration
                      -- AND l.dat_booking >= 1200319 THEN
                       AND l.dat_booking >= '2020-03-19' THEN
                   CASE
                     WHEN l.aktion_id <> '' THEN 1002
                     ELSE 1001
                   END
                 WHEN l.mandant_id IN ( 6 )
                      --bartosiewiczadm - cloud migration
                      --AND l.dat_booking >= 1200914 THEN
                      AND l.dat_booking >= '2020-09-14' THEN
                   CASE
                     WHEN l.aktion_id <> '' THEN 1002
                     ELSE 1001
                   END
                 WHEN l.mandant_id IN ( 5 )
                      --bartosiewiczadm - cloud migration
                      --AND l.dat_booking >= 1201119 THEN
                      AND l.dat_booking >= '2020-11-19' THEN
                   CASE
                     WHEN l.aktion_id <> '' THEN 1002
                     ELSE 1001
                   END
                 WHEN l.mandant_id IN ( 2, 3, 7, 8 ) THEN
                   CASE
                     WHEN l.aktion_id <> '' THEN 1002
                     ELSE 1001
                   END
                 ELSE COALESCE(r.bewart_id, 1001)
               END
                      AS bewart_id,
               dat_booking
                      AS dat,
               CASE
                 WHEN l.mandant_id IN ( 4 )
                      AND l.dat_booking >= '2020-03-19' THEN l.aktion_id
                 WHEN l.mandant_id IN ( 6 )
                      AND l.dat_booking >= '2020-09-14' THEN l.aktion_id
                 WHEN l.mandant_id IN ( 5 )
                      AND l.dat_booking >= '2020-11-19' THEN l.aktion_id
                 WHEN l.mandant_id IN ( 2, 3, 7, 8 )    THEN l.aktion_id
                 ELSE COALESCE(r.aktion_id, '')
               END
                      AS aktion_id,
               -1
                      AS herst_id,
               lkp_mwst_id
                      AS mwst_id,
               lkp_wrg
                      AS wrg_1,
               COALESCE(lkp_posten_id, ' ')
                      AS posten_id,
               0
                      AS bezugsweg_id,
               menge,
               ( umsatz_brutto )
                      AS umsatz_brutto_ohne_promo,
               Cast(umsatz_brutto_ohne_promo / ( 1 + ( lkp_mwst / 100 ) ) AS
                    DECIMAL(18, 4)) AS
               umsatz_netto,
               ( umsatz_brutto_ohne_promo - umsatz_netto )
                      AS umsatz_mwst_betrag
               -- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
               -- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)
               ,
               promo_fg,
               ean_kasse,
               lkp_umrechnungskurs
                      AS umrechnungskurs,
               umsatz_netto * lkp_umrechnungskurs
                      AS diff_umsatz_netto_konz,
               umsatz_mwst_betrag * lkp_umrechnungskurs
                      AS diff_umsatz_mwst_betrag_konz,
               bewart_det_id,
			   pv_aktion,
			   pv_bby,
			   pv_kdn_bby,
			   pv_kdp_bby,
			   pv_aktion_bby,
			   pv_aktion_kdn_bby,
			   pv_aktion_kdp_bby
        FROM   (SELECT mandant_id,
                       wup_id,
                       lkp_nb_id,
                       lkp_art_id,
                       lkp_posten_id,
                       dat_booking,
                       lkp_mwst,
                       lkp_mwst_id,
                       lkp_wrg,
                       lkp_umrechnungskurs,
                       promo_fg,
                       ean_kasse,
                       /*Datenlieferung an Externe, kommt erst noch... */
                       aktion_id,
                       Sum(umsatz_brutto_)           AS umsatz_brutto,
                       Sum(menge_)                   AS menge,
                       Sum(umsatz_promotion_brutto_) AS umsatz_promotion_brutto,
                       CASE
                           WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                           CASE
                             WHEN i.aktion_id = ''
                                  AND ((i.kundenkarte_id IS NULL AND i.kundenkarte_typ_id = 0) OR i.bde_kundenkarte_id IS NOT NULL)
								  THEN 100110
                             ELSE
                               CASE
                                 WHEN i.aktion_id = ''
                                      AND i.kundenkarte_id IS NOT NULL
                                      AND i.kundenkarte_typ_id IN (1, 2)
									  AND i.bde_kundenkarte_id IS NULL
									  THEN 100111  
                                 ELSE
                                   CASE
                                     WHEN i.aktion_id <> ''
                                          AND ((i.kundenkarte_id IS NULL
                                          AND i.kundenkarte_typ_id = 0) OR i.bde_kundenkarte_id IS NOT NULL)
                                          AND i.aktion_id IS NOT NULL
                                          AND (i.bonuskauf_id IS NULL OR i.bonuskauf_id = 0)
										  THEN 100210
                                     ELSE
                                       CASE
                                         WHEN i.aktion_id <> ''
                                              AND i.kundenkarte_id IS NOT NULL
                                              AND i.kundenkarte_typ_id IN (1, 2)
											  AND i.bde_kundenkarte_id IS NULL
                                              AND i.aktion_id IS NOT NULL
                                              AND (i.bonuskauf_id IS NULL OR i.bonuskauf_id = 0)
											  THEN 100211
                                         ELSE
                                           CASE
                                             WHEN i.aktion_id <> ''
                                                  AND i.bonuskauf_id IS NOT NULL
                                                  AND (((i.aktion_typ_id IS NULL OR i.aktion_typ_id = '') AND ((i.kundenkarte_id IS NULL AND i.kundenkarte_typ_id = 0) OR i.bde_kundenkarte_id IS NOT NULL))
												      OR (i.aktion_typ_id IN ('KDN', 'KDP') AND i.bde_kundenkarte_id IS NOT NULL))
                                           THEN 100220
                                             ELSE
                                               CASE
                                                 WHEN i.aktion_id <> ''
                                                      AND i.kundenkarte_id IS NOT NULL
                                                      AND i.kundenkarte_typ_id IN (1, 2) 
													  AND i.bde_kundenkarte_id IS NULL
                                                      AND i.bonuskauf_id IS NOT NULL
													  AND i.bonuskauf_id_lb IS NOT NULL
                                                      AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '')
                                               THEN 100221
                                                 ELSE
                                                   CASE
                                                     WHEN i.aktion_id <> ''
                                                        AND i.kundenkarte_id IS NOT NULL
                                                        AND i.kundenkarte_typ_id IN (1, 2) 
                                                        AND i.bonuskauf_id IS NOT NULL
													    AND i.bonuskauf_id_lb IS NULL
                                                     THEN 100231
                                                       ELSE
                                                         CASE
                                                           WHEN i.aktion_id <> ''
                                                             AND i.bonuskauf_id IS NOT NULL 
                                                             AND i.aktion_typ_id IN ('KDN', 'KPB')
															 AND i.bde_kundenkarte_id IS NULL
                                                           THEN 100231
                                                         ELSE
                                                           CASE
                                                             WHEN i.aktion_id <> ''
                                                               AND i.bonuskauf_id IS NOT NULL
                                                               AND i.aktion_typ_id = 'KDP' 
															   AND i.bde_kundenkarte_id IS NULL
											                 THEN 100241
                                                           ELSE 9999
                                                   END
                                                END
                                             END
                                          END
                                       END
                                    END
                                 END
                              END
                           END
                         ELSE 9999
                       END AS bewart_det_id,
					   SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                  CASE
                                     WHEN i.aktion_id <> ''
									      AND i.aktion_id IS NOT NULL
                                          AND (i.bonuskauf_id IS NULL OR i.bonuskauf_id = 0)																						  
                                          AND i.kundenkarte_id IS NULL
                                          AND i.kundenkarte_typ_id = 0
										  AND i.vk_aktion_brutto IS NOT NULL
										  --AND i.vk_aktion_brutto <> 0	
								     THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
                                     ELSE
                                       CASE
                                         WHEN i.aktion_id <> ''
									        AND i.aktion_id IS NOT NULL
                                            AND (i.bonuskauf_id IS NULL OR i.bonuskauf_id = 0)											
                                            AND i.kundenkarte_id IS NOT NULL
                                            AND i.kundenkarte_typ_id IN (1, 2) 
											AND i.bde_kundenkarte_id IS NOT NULL
											AND i.vk_aktion_brutto IS NOT NULL
											  --AND i.vk_aktion_brutto <> 0	
										 THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
										 ELSE
                                           CASE
                                             WHEN i.aktion_id <> ''
									            AND i.aktion_id IS NOT NULL
                                                AND (i.bonuskauf_id IS NULL OR i.bonuskauf_id = 0)
                                                AND i.kundenkarte_id IS NOT NULL
                                                AND i.kundenkarte_typ_id IN (1, 2) 
												AND i.bde_kundenkarte_id IS NULL
											    AND i.vk_aktion_brutto IS NOT NULL
											  --AND i.vk_aktion_brutto <> 0	
										     THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
									      ELSE 0
									   END
									END   
								 END	
						ELSE 0	 
						END) AS pv_aktion,
                         SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN 
                                    CASE
										 WHEN i.kundenkarte_id IS NULL
                                              AND i.aktion_id <> ''
                                              AND i.kundenkarte_typ_id = 0
											  AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                              AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '')
											  AND i.konditionsart_id <> 'N'
									     THEN COALESCE((i.betrag_promo_brutto_NULL/(1+(lkp_mwst/100))),0)
                                         ELSE
                                           CASE
                                             WHEN i.kundenkarte_id IS NOT NULL
											      AND i.aktion_id <> ''																			  
                                                  AND i.kundenkarte_typ_id IN (1, 2) 
												  AND i.bde_kundenkarte_id IS NOT NULL
                                                  AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                                  AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '' OR i.aktion_typ_id IN ('KDP', 'KDN'))
												  AND i.konditionsart_id <> 'N'
                                             THEN COALESCE((i.betrag_promo_brutto_NULL/(1+(lkp_mwst/100))),0)
											 ELSE
                                               CASE
                                                 WHEN i.kundenkarte_id IS NOT NULL
											       AND i.aktion_id <> ''
                                                   AND i.kundenkarte_typ_id IN (1, 2)
											       AND i.bde_kundenkarte_id IS NULL
                                                   AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                                   AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '')
												   AND i.konditionsart_id <> 'N'
                                                 THEN COALESCE((i.betrag_promo_brutto_NULL/(1+(lkp_mwst/100))),0)
                                               ELSE
                                               CASE
                                                WHEN i.bonuskauf_id IS NOT NULL
                                                  AND i.aktion_typ_id IN ('KDN', 'KPB')
                                                  AND i.bde_kundenkarte_id IS NULL
                                                  AND i.betrag_promo_brutto_NULL IS NOT NULL
                                                THEN COALESCE((i.betrag_promo_brutto_NULL/(1+(lkp_mwst/100))),0)
                                                ELSE 
                                                CASE  
                                                  WHEN i.bonuskauf_id IS NOT NULL
                                                    AND i.aktion_typ_id = 'KDP'
                                                    AND i.bde_kundenkarte_id IS NULL
                                                    AND i.betrag_promo_brutto_NULL IS NOT NULL
                                                  THEN COALESCE((i.betrag_promo_brutto_NULL/(1+(lkp_mwst/100))),0)
                                                ELSE 0
                                                END
                                            END
									    END
									END   
								END	
						ELSE 0
						END) AS pv_bby,
                         SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                    CASE  
									  WHEN i.bonuskauf_id IS NOT NULL
                                         --AND i.aktion_id <> '' 
                                         AND i.aktion_typ_id IN ('KDN', 'KPB')
										 AND i.bde_kundenkarte_id IS NULL
                                      THEN COALESCE((i.betrag_promo_brutto_KDN/(1+(lkp_mwst/100))),0)
                                     ELSE CASE  
                                      WHEN i.bonuskauf_id IS NOT NULL
                                         --AND i.aktion_id <> '' 
                                         AND i.aktion_typ_id = 'KDP'
                                         AND i.bde_kundenkarte_id IS NULL  
                                         AND betrag_promo_brutto_KDN IS NOT NULL
                                      THEN COALESCE((i.betrag_promo_brutto_KDN/(1+(lkp_mwst/100))),0)
                                    ELSE 0                  
                                END	                   
						  END
						ELSE 0
						END) AS pv_kdn_bby,
						SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                    CASE  
									  WHEN i.bonuskauf_id IS NOT NULL
                                         --AND i.aktion_id <> '' 
                                         AND i.aktion_typ_id = 'KDP'
										 AND i.bde_kundenkarte_id IS NULL										   
                                      THEN COALESCE((i.betrag_promo_brutto_KDP/(1+(lkp_mwst/100))),0)
									ELSE 0
						  END
						ELSE 0
						END) AS pv_kdp_bby,
                        SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                   CASE
                                     WHEN i.aktion_id <> ''
                                          AND i.aktion_id IS NOT NULL
                                          AND i.kundenkarte_id IS NULL
                                          AND i.kundenkarte_typ_id = 0
										  AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                          AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '')
										  AND i.vk_aktion_brutto IS NOT NULL
										  --AND i.vk_aktion_brutto <> 0	
                                          THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
                                     ELSE
                                       CASE
                                         WHEN i.aktion_id <> ''
                                              AND i.aktion_id IS NOT NULL
                                            AND i.kundenkarte_id IS NULL
                                            AND i.kundenkarte_typ_id = 0
											AND i.bde_kundenkarte_id IS NOT NULL
										    AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                            AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '' OR i.aktion_typ_id IN ('KDP', 'KDN'))
										    AND i.vk_aktion_brutto IS NOT NULL
										    --AND i.vk_aktion_brutto <> 0	
                                         THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
                                       ELSE
                                         CASE
                                           WHEN i.aktion_id <> ''
                                                AND i.aktion_id IS NOT NULL
                                              AND i.kundenkarte_id IS NOT NULL
                                                AND i.kundenkarte_typ_id IN (1, 2) 
												AND i.bde_kundenkarte_id IS NULL
											  AND i.bonuskauf_id IS NOT NULL AND i.bonuskauf_id <> 0
                                              AND (i.aktion_typ_id IS NULL OR i.aktion_typ_id = '')
											  AND i.vk_aktion_brutto IS NOT NULL
											  --AND i.vk_aktion_brutto <> 0	
                                              THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
									 ELSE 0
									   END
									END   
								END	
	                    ELSE 0		  
						END) AS pv_aktion_bby,
                        SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                   CASE
                                     WHEN i.aktion_id <> ''
                                          AND i.aktion_id IS NOT NULL
                                          AND i.kundenkarte_id IS NULL
                                          AND i.kundenkarte_typ_id = 0
                                          AND i.bonuskauf_id IS NOT NULL
                                          AND i.aktion_typ_id IN ('KDN', 'KPB')
										  AND i.bde_kundenkarte_id IS NULL
										  AND i.vk_aktion_brutto IS NOT NULL
										  --AND i.vk_aktion_brutto <> 0	
                                          THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
                                     ELSE
                                       CASE
                                         WHEN i.aktion_id <> ''
                                              AND i.aktion_id IS NOT NULL
                                              AND i.kundenkarte_id IS NOT NULL
                                              AND i.kundenkarte_typ_id IN (1, 2) 
                                              AND i.bonuskauf_id IS NOT NULL
                                              AND i.aktion_typ_id IN ('KDN', 'KPB')
											  AND i.bde_kundenkarte_id IS NULL
											  AND i.vk_aktion_brutto IS NOT NULL
											  --AND i.vk_aktion_brutto <> 0	
                                              THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
									 ELSE 0
									   END
									END   
						ELSE 0	 
						END) AS pv_aktion_kdn_bby,
                        SUM(CASE
                         WHEN ( i.mandant_id IN ( 4 )
                                AND i.dat_booking >= '2020-03-19' )
                               OR ( i.mandant_id IN ( 6 )
                                    AND i.dat_booking >= '2020-09-14' )
                               OR ( i.mandant_id IN ( 5 )
                                    AND i.dat_booking >= '2020-11-19' )
                               OR ( i.mandant_id IN ( 2, 3, 7, 8 ) ) THEN
                                   CASE
                                     WHEN i.aktion_id <> ''
                                          AND i.aktion_id IS NOT NULL	
                                          AND i.kundenkarte_id IS NULL
                                          AND i.kundenkarte_typ_id = 0									  
                                          AND i.bonuskauf_id IS NOT NULL
										  AND i.bde_kundenkarte_id IS NULL
                                          AND i.aktion_typ_id = 'KDP'
										  AND i.vk_aktion_brutto IS NOT NULL
										  --AND i.vk_aktion_brutto <> 0	
                                          THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
                                     ELSE
                                       CASE
                                         WHEN i.aktion_id <> ''
                                              AND i.aktion_id IS NOT NULL
                                              AND i.kundenkarte_id IS NOT NULL
                                              AND i.kundenkarte_typ_id IN (1, 2) 
                                              AND i.bonuskauf_id IS NOT NULL
											  AND i.bde_kundenkarte_id IS NULL
                                              AND i.aktion_typ_id = 'KDP'
											  AND i.vk_aktion_brutto IS NOT NULL 
											  --AND i.vk_aktion_brutto <> 0										  
                                              THEN COALESCE(((i.vk_aktion_brutto/(1+(lkp_mwst/100)))-(i.vk_brutto/(1+(lkp_mwst/100))))*i.menge_,0)
									 ELSE 0
									   END
									END   
						ELSE 0	 
						END) AS pv_aktion_kdp_bby
                FROM   (SELECT mandant_id,
                               wup_id,
                               lkp_nb_id,
                               lkp_art_id,
                               lkp_posten_id,
                               dat_booking,
                               lkp_mwst,
                               lkp_mwst_id,
                               lkp_wrg,
                               lkp_umrechnungskurs,
                               promo_fg,
                               ean_kasse
                               /*Datenlieferung an Externe, kommt erst noch... */
                               ,
                               aktion_id,
                               kundenkarte_id,
                               kundenkarte_typ_id,
                               bonuskauf_id,
                               aktion_typ_id,
                               konditionsart_id,
                               vk_aktion_brutto              AS vk_aktion_brutto,
                               vk_brutto                     AS vk_brutto,
                               bonuskauf_id_lb,
                               bde_kundenkarte_id,
                               SUM(betrag_promo_brutto_KDN)      AS betrag_promo_brutto_KDN,
                               SUM(betrag_promo_brutto_KDP)      AS betrag_promo_brutto_KDP,
                               SUM(betrag_promo_brutto_NULL)     AS betrag_promo_brutto_NULL,
                               SUM(umsatz_brutto)            AS umsatz_brutto_,
                               SUM(menge)                    AS menge_,
                               SUM(umsatz_promotion_brutto)  AS umsatz_promotion_brutto_
                        FROM   (
                               -- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
                               SELECT z.mandant_id,
                                      z.bon_id,
                                      z.wup_id,
                                      z.lkp_nb_id,
                                      z.lkp_art_id,
                                      z.lkp_posten_id,
                                      z.dat_booking,
                                      z.bon_zeile,
                                      z.umsatz_brutto,
                                      z.menge,
                                      z.lkp_mwst,
                                      z.lkp_mwst_id,
                                      z.lkp_wrg,
                                      z.lkp_umrechnungskurs,
                                      COALESCE(promotion_brutto, 0) AS
                                      umsatz_promotion_brutto,
                                      CASE
                                        WHEN umsatz_promotion_brutto <> 0 
										     AND z.bonuskauf_id IS NOT NULL
											 AND z.bonuskauf_id <> 0
										THEN 1
                                        ELSE 0
                                      END                           AS promo_fg
                                      /*Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist*/
                                      ,
                                      z.ean_kasse,
                                      CASE
                                        WHEN p.mandant_id IN ( 4 )
                                             AND z.dat_booking >= '2020-03-19'
                                             AND p.aktion_id <> '' THEN
                                        p.aktion_id
                                        WHEN p.mandant_id IN ( 4 )
                                             AND z.dat_booking >= '2020-03-19'
                                             AND p.aktion_id = '' THEN
                                        z.aktion_id
                                        WHEN p.mandant_id IN ( 6 )
                                             AND z.dat_booking >= '2020-09-14'
                                             AND p.aktion_id <> '' THEN
                                        p.aktion_id
                                        WHEN p.mandant_id IN ( 6 )
                                             AND z.dat_booking >= '2020-09-14'
                                             AND p.aktion_id = '' THEN
                                        z.aktion_id
                                        WHEN p.mandant_id IN ( 5 )
                                             AND z.dat_booking >= '2020-11-19'
                                             AND p.aktion_id <> '' THEN
                                        p.aktion_id
                                        WHEN p.mandant_id IN ( 5 )
                                             AND z.dat_booking >= '2020-11-19'
                                             AND p.aktion_id = '' THEN
                                        z.aktion_id
                                        WHEN p.mandant_id IN ( 2, 3, 7, 8 )
                                             AND p.aktion_id <> '' THEN
                                        p.aktion_id
                                        WHEN p.mandant_id IN ( 2, 3, 7, 8 )
                                             AND p.aktion_id = '' THEN
                                        z.aktion_id
                                        ELSE z.aktion_id
                                      END                           AS aktion_id
,
                                      z.kundenkarte_id,
                                      z.kundenkarte_typ_id,
                                      z.bonuskauf_id,
                                      z.aktion_typ_id,
                                      z.vk_aktion_brutto,
                                      z.vk_brutto,
                                      z.betrag_promo_brutto_KDN,
                                      z.betrag_promo_brutto_KDP,
                                      z.betrag_promo_brutto_NULL,
                                      z.konditionsart_id,
                                      z.bonuskauf_id_lb,
                                      z.bde_kundenkarte_id
FROM   DBP_ETL.kmo_artbew_bon_1 z
 -- Ermittlung Promotionsbetrag pro Bon Zeile
 LEFT OUTER JOIN (SELECT a.mandant_id,
                         a.bon_id,
                         a.dat_booking,
                         a.bon_zeile,
                         Max(COALESCE(b.aktion_id, '')) AS aktion_id,
                         Sum(a.umsatz_brutto) AS promotion_brutto
                  FROM DBP_ETL.kmo_artbew_bon_promotion_1 a
 LEFT JOIN DBP_DATA.l_bonuskauf_1 b
        ON a.mandant_id = b.mandant_id
           AND a.bonuskauf_id = b.bonuskauf_id
           AND a.dat_booking BETWEEN b.dat_von AND b.dat_bis
                  GROUP  BY 1,
                            2,
                            3,
                            4) p
              ON z.mandant_id = p.mandant_id
                 AND z.bon_id = p.bon_id
                 AND z.dat_booking = p.dat_booking
                 AND z.bon_zeile = p.bon_zeile) z
GROUP  BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22
) i
GROUP  BY 1,2,3,4,5,6,7,8,9,10,11,12,13,17
) l
LEFT OUTER JOIN DBP_ETL_PROCESS.marktabschriften_stamm_1 r
ON l.mandant_id = r.mandant_id
AND l.lkp_art_id = r.art_id
AND l.wup_id = r.wup_id
AND l.lkp_nb_id = r.nb_id
AND l.dat_booking = r.dat
) a
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.artbew_kmo_tmp_crm_1
(
mandant_id
,wup_id
,nb_id
,art_id
,gp_id
,einkaufsorganisation_id
,bewart_id
,dat
,aktion_id
,herst_id
,mwst_id
,wrg_1
,posten_id
,bezugsweg_id
,menge
,umsatz_netto
,umsatz_mwst_betrag
,promo_fg
,ean_kasse
--  ,umrechnungskurs
,diff_umsatz_netto_konz
,diff_umsatz_mwst_betrag_konz
,kundenkarte_id
,bon_id

)
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,gp_id
,einkaufsorganisation_id
,bewart_id
,dat
,aktion_id
,herst_id
,mwst_id
,wrg_1
,posten_id
,bezugsweg_id
,menge
,umsatz_netto
,umsatz_mwst_betrag
,promo_fg
,ean_kasse
--  ,umrechnungskurs
,diff_umsatz_netto_konz
,diff_umsatz_mwst_betrag_konz
,kundenkarte_id
,bon_id
FROM
(
SELECT
l.mandant_id AS mandant_id
,l.wup_id AS wup_id
,lkp_nb_id AS nb_id
,lkp_art_id AS art_id
,-1 AS gp_id
,-1 AS einkaufsorganisation_id
,CASE
WHEN l.mandant_id IN (4) AND
l.dat_booking >= '2020-03-19'
THEN CASE
WHEN l.aktion_id <> ''
THEN 1002
ELSE 1001
END
WHEN l.mandant_id IN (6) AND
l.dat_booking >= '2020-09-14'
THEN CASE
WHEN l.aktion_id <> ''
THEN 1002
ELSE 1001
END
WHEN l.mandant_id IN (5) AND
l.dat_booking >= '2020-11-19'
THEN CASE
WHEN l.aktion_id <> ''
THEN 1002
ELSE 1001
END
WHEN l.mandant_id IN (2,7)
THEN CASE
WHEN l.aktion_id <> ''
THEN 1002
ELSE 1001
END
ELSE COALESCE(r.bewart_id, 1001)
END AS bewart_id
,dat_booking AS dat
,CASE
WHEN l.mandant_id IN (4) AND
l.dat_booking >= '2020-03-19'
THEN l.aktion_id
WHEN l.mandant_id IN (6) AND
l.dat_booking >= '2020-09-14'
THEN l.aktion_id
WHEN l.mandant_id IN (5) AND
l.dat_booking >= '2020-11-19'
THEN l.aktion_id
WHEN l.mandant_id IN (2,7)
THEN l.aktion_id
ELSE COALESCE(r.aktion_id,'')
END AS aktion_id
,-1 AS herst_id
,lkp_mwst_id AS mwst_id
,lkp_wrg AS wrg_1
,COALESCE(lkp_posten_id, ' ') AS posten_id
,0 AS bezugsweg_id
,menge_ AS menge
,(umsatz_brutto_) AS umsatz_brutto_ohne_promo
,CAST(umsatz_brutto_ohne_promo / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_netto
,(umsatz_brutto_ohne_promo - umsatz_netto) AS umsatz_mwst_betrag
-- die folgenden EK Attribute werden bis auf weiteres mit dem Wert 0
-- im abschließenden INSERT INTO in die Zieltabelle verschluesselt initialisiert (s.u.)
,promo_fg
,ean_kasse
,lkp_umrechnungskurs AS umrechnungskurs
,umsatz_netto * lkp_umrechnungskurs AS diff_umsatz_netto_konz
,umsatz_mwst_betrag * lkp_umrechnungskurs AS diff_umsatz_mwst_betrag_konz
,kundenkarte_id
,bon_id
FROM
(
-- Bonzeilen zusammenfassen damit keine Rundungsdifferenzen bei der MWST
-- Berechnung im Vergleich zur Wpuums auftreten.
SELECT
mandant_id
,wup_id
,lkp_nb_id
,lkp_art_id
,lkp_posten_id
,dat_booking
,lkp_mwst
,lkp_mwst_id
,lkp_wrg
,lkp_umrechnungskurs
,promo_fg
,ean_kasse  /*Datenlieferung an Externe, kommt erst noch... */
,aktion_id
,kundenkarte_id
,bon_id
,SUM(umsatz_brutto) AS umsatz_brutto_
,SUM(menge) AS menge_
,SUM(umsatz_promotion_brutto) AS umsatz_promotion_brutto_
FROM
(
-- Ermittlung der Promotionsbetraege pro Bonzeile und Kennzeichnung promo_fg
SELECT
z.mandant_id
,z.bon_id
,z.wup_id
,z.lkp_nb_id
,z.lkp_art_id
,z.lkp_posten_id
,z.dat_booking
,z.bon_zeile
,z.umsatz_brutto
,z.menge
,z.lkp_mwst
,z.lkp_mwst_id
,z.lkp_wrg
,z.lkp_umrechnungskurs
,COALESCE(promotion_brutto, 0) AS umsatz_promotion_brutto
,CASE WHEN umsatz_promotion_brutto <> 0
THEN 1
ELSE 0
END AS promo_fg /*Kennzeichen ob in der Position ein Promotionsbetrag enthalten ist*/
,z.ean_kasse
,CASE
WHEN p.mandant_id IN (4) AND
z.dat_booking >= '2020-03-19' AND
p.aktion_id <> ''
THEN p.aktion_id
WHEN p.mandant_id IN (4) AND
z.dat_booking >= '2020-03-19' AND
p.aktion_id = ''
THEN z.aktion_id
WHEN p.mandant_id IN (6) AND
z.dat_booking >= '2020-09-14' AND
p.aktion_id <> ''
THEN p.aktion_id
WHEN p.mandant_id IN (6) AND
z.dat_booking >= '2020-09-14' AND
p.aktion_id = ''
THEN z.aktion_id
WHEN p.mandant_id IN (5) AND
z.dat_booking >= '2020-11-19' AND
p.aktion_id <> ''
THEN p.aktion_id
WHEN p.mandant_id IN (5) AND
z.dat_booking >= '2020-11-19' AND
p.aktion_id = ''
THEN z.aktion_id
WHEN p.mandant_id IN (2,7) AND
p.aktion_id <> ''
THEN p.aktion_id
WHEN p.mandant_id IN (2,7) AND
p.aktion_id = ''
THEN z.aktion_id
ELSE z.aktion_id
END AS aktion_id
,z.kundenkarte_id
FROM DBP_ETL.kmo_artbew_bon_1 z

-- Ermittlung Promotionsbetrag pro Bon Zeile
LEFT OUTER JOIN
(
SELECT
a.mandant_id
,a.bon_id
,a.dat_booking
,a.bon_zeile
,MAX(COALESCE(b.aktion_id,'')) AS aktion_id
,SUM(a.umsatz_brutto) AS promotion_brutto
FROM DBP_ETL.kmo_artbew_bon_promotion_1 a
LEFT JOIN DBP_DATA.l_bonuskauf_1 b
ON a.mandant_id = b.mandant_id AND
a.bonuskauf_id = b.bonuskauf_id AND
a.dat_booking BETWEEN b.dat_von AND b.dat_bis
GROUP BY 1,2,3,4
) p
ON z.mandant_id = p.mandant_id
AND z.bon_id = p.bon_id
AND z.dat_booking = p.dat_booking
AND z.bon_zeile = p.bon_zeile

WHERE z.mandant_id IN (2,4,7,6,5)

) z
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
) l

LEFT OUTER JOIN DBP_ETL_PROCESS.marktabschriften_stamm_1 r
ON l.mandant_id = r.mandant_id
AND l.lkp_art_id = r.art_id
AND l.wup_id = r.wup_id
AND l.lkp_nb_id = r.nb_id
AND l.dat_booking = r.dat
) a


GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.artbew_1 a
--WHERE a.dat = DBX_LOAD.kmo_artbew_bon_dat.dat
--AND (a.mandant_id, a.wup_id, a.dat) IN
--(
--SELECT
--mandant_id
--,wup_id
--,dat
--FROM DBX_LOAD.artbew_kmo_tmp_1
--)
--AND a.bewart_id <> 1010
--;
--
--Comment from validation checker
--error line 2 at position 14
--WHERE a.dat =  ^^^> DBP_ETL.kmo_artbew_bon_dat.dat
--invalid identifier 'DBP_ETL.KMO_ARTBEW_BON_DAT.DAT'
--translated statement
DELETE FROM DBP_DATA.artbew_1 a
-- bartosiewiczadm - cloud migration
-- WHERE a.dat = DBP_ETL.kmo_artbew_bon_dat.dat
WHERE a.dat IN ( SELECT dat 
        FROM DBP_ETL.kmo_artbew_bon_dat_1
      )
AND (a.mandant_id, a.wup_id, a.dat) IN
(
SELECT
mandant_id
,wup_id
,dat
FROM DBP_ETL.artbew_kmo_tmp_1
)
AND a.bewart_id <> 1010
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--DELETE FROM DBX_DATA.artbew_promotion_zu_1 a
--WHERE a.dat = DBX_LOAD.kmo_artbew_bon_dat.dat
--AND (a.mandant_id, a.wup_id, a.dat) IN
--(
--SELECT
--mandant_id
--,wup_id
--,dat
--FROM DBX_LOAD.artbew_kmo_tmp_1
--WHERE promo_fg = 1
--)
---- Promotionsbetraege aus Wpuums bis auf weiteres stehen lassen
--AND a.konditionsart_id <> 'RB19'
--;
--
--Comment from validation checker
--error line 2 at position 14
--WHERE a.dat =  ^^^> DBP_ETL.kmo_artbew_bon_dat.dat
--invalid identifier 'DBP_ETL.KMO_ARTBEW_BON_DAT.DAT'
--translated statement
DELETE FROM DBP_DATA.artbew_promotion_zu_1 a
-- bartosiewiczadm - cloud migration
-- WHERE a.dat = DBP_ETL.kmo_artbew_bon_dat.dat
WHERE a.dat IN ( SELECT dat 
        FROM DBP_ETL.kmo_artbew_bon_dat_1
      )
AND (a.mandant_id, a.wup_id, a.dat) IN
(
SELECT
mandant_id
,wup_id
,dat
FROM DBP_ETL.artbew_kmo_tmp_1
WHERE promo_fg = 1
)
-- Promotionsbetraege aus Wpuums bis auf weiteres stehen lassen
AND a.konditionsart_id <> 'RB19'
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_1
(
mandant_id
,wup_id
,nb_id
,art_id
,promo_fg
,gp_id
,einkaufsorganisation_id
,bewart_id
,dat
,aktion_id
,herst_id
,mwst_id
,wrg_1
,posten_id
,bezugsweg_id
,menge
,umsatz_netto
,umsatz_mwst_betrag
,ek_brutto
,ek_netto
,ek_nettonetto
,ek_kal_basis
,ek_mep
,einstandspreis
,logkostenzuschlag
,ek_netto_bnk
,ek_netto_bnk_sachk
,ean_kasse
--  ,umrechnungskurs 
  ,diff_umsatz_netto_konz
  ,diff_umsatz_mwst_betrag_konz
  ,bewart_det_id
  ,pv_aktion
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
  ,pv_aktion_bby  
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby 
)
SELECT
mandant_id
  ,wup_id
  ,nb_id
  ,art_id
  ,promo_fg
  ,gp_id
  ,einkaufsorganisation_id
  ,bewart_id
  ,dat
  ,aktion_id
  ,herst_id
  ,mwst_id
  ,wrg_1
  ,posten_id
  ,bezugsweg_id
  ,menge_sum
  ,umsatz_netto_sum
  ,umsatz_mwst_betrag_sum
  ,zero_enc AS ek_brutto
  ,zero_enc AS ek_netto
  ,zero_enc AS ek_nettonetto
  ,zero_enc AS ek_kal_basis
  ,zero_enc AS ek_mep
  ,zero_enc AS einstandspreis
  ,0 AS logkostenzuschlag
  ,zero_enc AS ek_netto_bnk
  ,zero_enc AS ek_netto_bnk_sachk
  ,ean_kasse
--  ,umrechnungskurs 
  ,diff_umsatz_netto_konz
  ,diff_umsatz_mwst_betrag_konz
  ,bewart_det_id
  ,pv_aktion
  ,pv_bby
  ,pv_kdn_bby
  ,pv_kdp_bby
  ,pv_aktion_bby  
  ,pv_aktion_kdn_bby
  ,pv_aktion_kdp_bby   
FROM
(
  SELECT
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,promo_fg
    ,gp_id
    ,einkaufsorganisation_id
    ,bewart_id
    ,dat
    ,aktion_id
    ,herst_id
    ,mwst_id
    ,wrg_1
    ,posten_id
    ,bezugsweg_id
    ,SUM(menge             ) AS menge_sum
    ,SUM(umsatz_netto      ) AS umsatz_netto_sum
    ,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
    ,0                       AS zero_enc
    ,ean_kasse
--  ,umrechnungskurs    
    ,SUM(diff_umsatz_netto_konz) diff_umsatz_netto_konz
    ,SUM(diff_umsatz_mwst_betrag_konz) diff_umsatz_mwst_betrag_konz 
	,bewart_det_id
	,pv_aktion
	,pv_bby
	,pv_kdn_bby
    ,pv_kdp_bby
    ,pv_aktion_bby  
    ,pv_aktion_kdn_bby
    ,pv_aktion_kdp_bby 	
  FROM DBP_ETL.artbew_kmo_tmp_1
  GROUP BY
     mandant_id
    ,wup_id
    ,nb_id
    ,art_id
    ,promo_fg
    ,gp_id
    ,einkaufsorganisation_id
    ,bewart_id
    ,dat
    ,aktion_id
    ,herst_id
    ,mwst_id
    ,wrg_1
    ,posten_id
    ,bezugsweg_id
    ,zero_enc
    ,ean_kasse
--  ,umrechnungskurs 
    ,bewart_det_id
	,pv_aktion
	,pv_bby
	,pv_kdn_bby
    ,pv_kdp_bby
    ,pv_aktion_bby  
    ,pv_aktion_kdn_bby
    ,pv_aktion_kdp_bby 	
) a
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_DATA.artbew_promotion_zu_1
(
mandant_id
,wup_id
,nb_id
,art_id
,dat
,bonuskauf_id
,konditionsart_id
,wrg_id
,betrag_promo_netto
,betrag_mwst
,umrechnungskurs
,system_id
,ean_kasse
,menge_promo
,umsatz_promo_netto
,umsatz_mwst
)
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,dat
,bonuskauf_id
,konditionsart_id
,wrg_id
,SUM(betrag_promo_netto)
,SUM(betrag_mwst)
,umrechnungskurs
,system_id
,ean_kasse
,SUM(menge_promo)
,SUM(umsatz_promo_netto)
,SUM(umsatz_mwst)
FROM
(
SELECT
l.mandant_id AS mandant_id
,l.wup_id     AS wup_id
,l.lkp_nb_id  AS nb_id
,l.lkp_art_id AS art_id
,l.dat_booking AS dat
,p.bonuskauf_id
,p.konditionsart_id
,l.lkp_wrg    AS wrg_id
,CAST(p.umsatz_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS betrag_promo_netto
,(p.umsatz_brutto - betrag_promo_netto) AS betrag_mwst
,lkp_umrechnungskurs AS umrechnungskurs
,COALESCE(k.system_id, 0) AS system_id
,l.ean_kasse
,menge_promo AS menge_promo
,CAST(p.umsatz_promo_brutto / (1+(lkp_mwst/100)) AS DECIMAL(18,4)) AS umsatz_promo_netto
,(umsatz_promo_brutto - umsatz_promo_netto) AS umsatz_mwst
FROM DBP_ETL.kmo_artbew_bon_1 l

INNER JOIN DBP_ETL.kmo_artbew_bon_promotion_1 p
ON l.mandant_id = p.mandant_id
AND l.bon_id = p.bon_id
AND l.dat_booking = p.dat_booking
AND l.bon_zeile = p.bon_zeile

-- Ermittlung System_id fuer oben eingetragene Konditionsarten
LEFT OUTER JOIN DBP_DATA.l_konditionsart_1 k
ON p.mandant_id = k.mandant_id
AND p.konditionsart_id = k.konditionsart_id
) p

GROUP BY
mandant_id
,wup_id
,nb_id
,art_id
,dat
,bonuskauf_id
,konditionsart_id
,wrg_id
,umrechnungskurs
,system_id
,ean_kasse
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.artbew_agg_wt_1
(
mandant_id
,wup_id
,nb_id
,dat
)
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_ETL.artbew_kmo_tmp_1
WHERE
(
mandant_id
,wup_id
,nb_id
,dat
)
NOT IN
(
SELECT
mandant_id
,wup_id
,nb_id
,dat
FROM DBP_DATA.artbew_agg_wt_1
)

GROUP BY 1,2,3,4
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.wupcal_1

SET datenlieferung_artbew = 1
, dat_extrakt_umsatz = CURRENT_DATE
, umsatz_brutto_ods_verkauf = (umsatz_netto_sum + umsatz_mwst_betrag_sum)

FROM (SELECT
mandant_id mandant_id_
,wup_id wup_id_
,nb_id nb_id_
,dat dat_
,SUM(umsatz_netto      ) AS umsatz_netto_sum
,SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
FROM DBP_ETL.artbew_kmo_tmp_1
GROUP BY 1,2,3,4 ) x1
 WHERE
mandant_id = mandant_id_
AND wup_id = wup_id_
AND nb_id = nb_id_
AND dat = dat_
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
UPDATE DBP_DATA.wupcal_1

SET bonanzahl = anz_kunden_
, bonanzahl_imbiss = anz_kunden_imbiss_
, umsatz_brutto_ods_kassenabschluss = umsatz_brutto_ods_kassenabschluss_
, datenlieferung_bonanzahl = 1
FROM (
SELECT k.mandant_id mandant_id_,
k.wup_id wup_id_,
k.bon_dat dat_,
SUM(k.anz_kunden) - SUM(k.anz_kunden_imbiss) anz_kunden_,
SUM(k.anz_kunden_imbiss) anz_kunden_imbiss_,
SUM(k.umsatz_brutto) umsatz_brutto_ods_kassenabschluss_
FROM DBP_ODS.ods_bon_kassenabschluss_1 k
INNER JOIN (SELECT DISTINCT mandant_id,wup_id,dat FROM DBP_ETL.artbew_kmo_tmp_1) a
ON a.mandant_id = k.mandant_id
AND a.wup_id = k.wup_id
AND a.dat = k.bon_dat
GROUP BY 1,2,3) S WHERE mandant_id = mandant_id_
AND wup_id = wup_id_
AND dat = dat_;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.wup_1
SET kassentyp  = 'KPO'
WHERE (mandant_id,nb_id,wup_id) IN (SELECT mandant_id, nb_id, wup_id FROM DBP_ETL.artbew_kmo_tmp_1)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_wpuums_art_gp_wup_zu_1
(
mandant_id
,wup_id
,nb_id
,art_id
,dat
,bezugsweg_id
,anz_ek_infosatz
,anz_ek_orderbuch
,bq_gp_id
,bq_ekorg
,bq_findung_id
,regel_gp_id
,regel_ekorg
,ref_wup_id
,ref_nb_id
,wg_id
,kreistyp_gruppe_id
,umrechnungskurs
)
SELECT
mandant_id
,wup_id
,lkp_nb_id
,lkp_art_id
,dat_booking
,0 AS bezugsweg_id
,0 AS anz_ek_infosatz
,0 AS anz_ek_orderbuch
,0 AS bq_gp_id
,0 AS bq_ekorg
,0 AS bq_findung_id
,0 AS regel_gp_id
,0 AS regel_ekorg
,0 AS ref_wup_id
,0 AS ref_nb_id
,0 AS wg_id
,'' AS kreistyp_gruppe_id
,lkp_umrechnungskurs
FROM DBP_ETL.kmo_artbew_bon_1 a

WHERE (mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN
(
SELECT
mandant_id
,wup_id
,nb_id
,art_id
,dat
FROM DBP_ETL.kmo_wpuums_art_gp_wup_zu_1
)

GROUP BY  /*gruppierung wg. Ean_1 und Promoflag erforderlich*/
mandant_id
,wup_id
,lkp_nb_id
,lkp_art_id
,dat_booking
,lkp_umrechnungskurs
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
UPDATE DBP_ODS.bon_load_status_1
SET artbew_fg = 1

WHERE xml_name IN
(
SELECT
xml_name
FROM DBP_ETL.kmo_artbew_bon_delta_1
)
;

DELETE FROM DBP_DATA.crm_kartebew_1 a
WHERE a.dat in ( SELECT distinct dat FROM DBP_ETL.kmo_artbew_bon_dat_1 )
AND (a.mandant_id, a.wup_id, a.dat) IN 
(SELECT distinct mandant_id,wup_id,dat FROM DBP_ETL.artbew_kmo_tmp_crm_1)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.crm_kartebew_1 
(mandant_id
,wup_id
,nb_id
,kundenkarte_id
,dat
,wrg_1
,umsatz_netto_sa
,umsatz_netto_af
,umsatz_brutto_sa
,umsatz_brutto_af
,anz_bons)
SELECT mandant_id,
wup_id,
nb_id,
kundenkarte_id,
dat,
wrg_1,
SUM(CASE WHEN bewart_id = 1002 THEN umsatz_netto ELSE 0 END) AS umsatz_netto_sa,
SUM(CASE WHEN bewart_id = 1001 THEN umsatz_netto ELSE 0 END) AS umsatz_netto_af,
SUM(CASE WHEN bewart_id = 1002 THEN umsatz_netto + umsatz_mwst_betrag ELSE 0 END) AS umsatz_brutto_sa,
SUM(CASE WHEN bewart_id = 1001 THEN umsatz_netto + umsatz_mwst_betrag ELSE 0 END) AS umsatz_brutto_af,
COUNT(DISTINCT bon_id) AS anz_bons
FROM DBP_ETL.artbew_kmo_tmp_crm_1
WHERE kundenkarte_id IS NOT NULL
GROUP BY 1,2,3,4,5,6
;

DELETE FROM DBP_DATA.crm_kartebew_1
WHERE dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE AND
      mandant_id = 1
;

INSERT INTO DBP_DATA.crm_kartebew_1 (mandant_id
,wup_id
,nb_id
,kundenkarte_id
,dat
,wrg_1
,umsatz_netto_sa
,umsatz_netto_af
,umsatz_brutto_sa
,umsatz_brutto_af
,anz_bons)
SELECT a.mandant_id,
a.wup_id,
0 AS nb_id,
a.kundenkarte_id,
a.bon_dat AS dat,
'EUR' AS wrg_id,
SUM(CASE WHEN z.aktion_id NOT IN ('','0','0000000000') THEN CAST((z.umsatz_brutto*100)/(100+(d.mwst)) AS DECIMAL(18,4)) ELSE 0 END) AS umsatz_netto_sa,
SUM(CASE WHEN z.aktion_id IN ('','0','0000000000') THEN CAST((z.umsatz_brutto*100)/(100+(d.mwst)) AS DECIMAL(18,4)) ELSE 0 END) AS umsatz_netto_af,
SUM(CASE WHEN z.aktion_id NOT IN ('','0','0000000000') THEN z.umsatz_brutto ELSE 0 END) AS umsatz_brutto_sa,
SUM(CASE WHEN z.aktion_id IN ('','0','0000000000') THEN z.umsatz_brutto ELSE 0 END) AS umsatz_brutto_af,
COUNT(DISTINCT a.bon_id) AS anz_bons

FROM DBP_ODS.ods_bon_kopf_1 a

JOIN DBP_ODS.ods_bon_verkauf_1 z
ON a.mandant_id = z.mandant_id
AND a.bon_id = z.bon_id
AND a.wup_id = z.wup_id
AND a.bon_dat = z.bon_dat

JOIN DBP_DATA.mwst_per_1 d
ON a.mandant_id = d.mandant_id AND
z.mwst_id = d.mwst_id AND
a.bon_dat BETWEEN d.dat_von AND d.dat_bis

WHERE a.bon_dat BETWEEN CURRENT_DATE-14 AND CURRENT_DATE AND
a.mandant_id = 1 AND
a.kundenkarte_id IS NOT NULL
GROUP BY 1,2,3,4,5,6
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.artbew_kmo_tmp_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.artbew_kmo_tmp_crm_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_aktion_relevant_1;

