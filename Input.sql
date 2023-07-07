/*  %sql
 CREATE OR REPLACE TEMPORARY VIEW tmp_view_fat_NotasClientes_cls
 AS  */
 SELECT
 
     HASH_EMPRESA                                  AS HASH_EMPRESA,
     HASH_EQUIPE_COMERCIAL                         AS HASH_EQUIPE_COMERCIAL
     , IF(st_NotaFiscal = '' OR st_NotaFiscal IS NULL, 'N/I',st_NotaFiscal)                                    AS st_NotaFiscal
     , IF(nr_NotaFiscal = '' OR nr_NotaFiscal IS NULL, 'N/I',nr_NotaFiscal)                                    AS nr_NotaFiscal
     , IF(nr_SerieNotaFiscal = '' OR nr_SerieNotaFiscal IS NULL, 'N/I',nr_SerieNotaFiscal)                     AS nr_SerieNotaFiscal
     ,HASH_CLIENTES                                                                                                  AS HASH_CLIENTES
     , HASH_VENDEDOR                                                                                                 AS HASH_VENDEDOR
     , HASH_REPRESENTANTE                                                                                            AS HASH_REPRESENTANTE
     , HASH_PRODUTOS                                                                                                 AS HASH_PRODUTOS
     , HASH_CFOP                                                                                                     AS HASH_CFOP
     , HASH_INTERCOMPANY                                                                                             AS HASH_INTERCOMPANY
     , HASH_MARCA_PRODUTO                             AS HASH_MARCA_PRODUTO
     , COALESCE(dt_NotaFiscal, '1900-01-01')                                                                       AS dt_NotaFiscal
     , COALESCE(dt_NotaOrigem, '1900-01-01')                                                                       AS dt_NotaOrigem
     , IF(nr_NotaFiscalOrigem = '' OR nr_NotaFiscalOrigem IS NULL, 'N/I', nr_NotaFiscalOrigem)                 AS nr_NotaFiscalOrigem
     , IF(nr_SerieNotaFiscalOrigem = '' OR nr_SerieNotaFiscalOrigem IS NULL, 'N/I', nr_SerieNotaFiscalOrigem)  AS nr_SerieNotaFiscalOrigem
     , IF(tp_Movimentacao = '' OR tp_Movimentacao IS NULL, 'N/I', tp_Movimentacao)                             AS tp_Movimentacao
     , IF(fl_Promocao = '' OR fl_Promocao IS NULL, 'N/I', fl_Promocao)                                         AS fl_Promocao
     , COALESCE(pc_DescontoVenda, 0.0000)                                                                          AS pc_DescontoVenda
     , COALESCE(tx_ComissaoRepresentante, 0.0000)                                                                  AS tx_ComissaoRepresentante
     , COALESCE(tx_ComissaoVendedor, 0.0000)                                                                       AS tx_ComissaoVendedor
     , COALESCE(qt_Produto, 0.0000)                                                                                AS qt_Produto
     , COALESCE(qt_DiaPrazoMedioRecebimento, 0.0000)                                                               AS qt_DiaPrazoMedioRecebimento
     , COALESCE(vl_ProdutoNota, 0.0000)                                                                            AS vl_ProdutoNota
     , COALESCE(vl_CustoMedio, 0.0000)                                                                             AS vl_CustoMedio
     , COALESCE(vl_Desconto, 0.0000)                                                                               AS vl_Desconto
     , COALESCE(vl_Acrescimo, 0.0000)                                                                              AS vl_Acrescimo
     , COALESCE(vl_Frete, 0.0000)                                                                                  AS vl_Frete
     , COALESCE(vl_COFINS, 0.0000)                                                                                 AS vl_COFINS
     , COALESCE(vl_PIS, 0.0000)                                                                                    AS vl_PIS
     , COALESCE(vl_ICMS, 0.0000)                                                                                   AS vl_ICMS
     , COALESCE(vl_TaxaBanco, 0.0000)                                                                              AS vl_TaxaBanco
     , COALESCE(vl_IPI, 0.0000)                                                                                    AS vl_IPI
     , COALESCE(vl_ISS, 0.0000)                                                                                    AS vl_ISS
     , COALESCE(vl_ICMSST, 0.0000)                                                                                 AS vl_ICMSST
     , COALESCE(vl_BrutoDocumento, 0.0000)                                                                         AS vl_BrutoDocumento
     , COALESCE(vl_ImpostosDocumento, 0.0000)                                                                      AS vl_ImpostosDocumento
     , COALESCE(vl_CustoUltimaEntrada, 0.0000)                                                                     AS vl_CustoUltimaEntrada
     , COALESCE(vl_PrecoVendaBruto, 0.0000)                                                                        AS vl_PrecoVendaBruto
     , COALESCE(vl_ProdutoCustoReposicao, 0.0000)                                                                  AS vl_ProdutoCustoReposicao
     , COALESCE(vl_ProdutoPrecoVenda, 0.0000)                                                                      AS vl_ProdutoPrecoVenda
     , IF(ds_CondicaoPagamento = '' OR ds_CondicaoPagamento IS NULL, 'N/I', ds_CondicaoPagamento)              AS ds_CondicaoPagamento
     , IF(fl_VendaExterna = '' OR fl_VendaExterna IS NULL, 'N/I', fl_VendaExterna)                             AS fl_VendaExterna
     , IF(ds_TipoTransporte = '' OR ds_TipoTransporte IS NULL, 'N/I', ds_TipoTransporte)                       AS ds_TipoTransporte
     , IF(cd_TabelaPreco = '' OR cd_TabelaPreco IS NULL, 'N/I', cd_TabelaPreco)                                AS cd_TabelaPreco
     , (Coalesce(FT.vl_ProdutoNota, 0) + Coalesce(FT.VL_ICMSST, 0) + Coalesce(FT.vl_Frete, 0)
              + Coalesce(FT.vl_TaxaBanco, 0) + Coalesce(FT.vl_Acrescimo, 0) - Coalesce(FT.vl_Desconto, 0)
              + Coalesce(FT.vl_IPI, 0)
             )                                                                                                       AS vl_ReceitaBruta
     , (Coalesce(FT.vl_ProdutoNota , 0)
              -- + Coalesce(FT.VL_ICMSST, 0)
              + Coalesce(FT.vl_Frete, 0) + Coalesce(FT.vl_TaxaBanco, 0) + Coalesce(FT.vl_Acrescimo, 0)
              - Coalesce(FT.vl_Desconto, 0) - Coalesce(FT.vl_COFINS, 0) - Coalesce(FT.vl_PIS, 0)
              - Coalesce(FT.vl_ISS, 0) - Coalesce(FT.vl_ICMS, 0)
             )                                                                                                       AS vl_ReceitaLiquida
     , IF(Coalesce(FT.qt_Produto, 0) = 0, 1, FT.qt_Produto)                                                          AS qt_ProdutoDIV
     , Coalesce(FT.vl_ProdutoNota, 0) / IF(Coalesce(FT.qt_Produto, 0) = 0, 1, FT.qt_Produto)                         AS vl_ProdutoNotaUnit
     , Coalesce(FT.vl_CustoMedio, 0) / IF(Coalesce(FT.qt_Produto, 0) = 0, 1, FT.qt_Produto)                          AS vl_CustoMedioProduto
     , COALESCE(vl_CustoMedioSistema, 0.0000)                                                                      AS vl_CustoMedioSistema
     , COALESCE(vl_CustoMedioProdutoSistema, 0.0000)                                                               AS vl_CustoMedioProdutoSistema
     , IF(id_ProdutosKit = '' OR id_ProdutosKit IS NULL, 'N/I', id_ProdutosKit)                                AS id_ProdutosKit
     , Coalesce(FT.vl_CustoMedio, 0) / IF(Coalesce(FT.qt_Produto, 0) = 0, 1, FT.qt_Produto)                          AS cd_PedidoWEB
     , IF(id_Transportadora = '' OR id_Transportadora IS NULL, 'N/I', id_Transportadora)                       AS id_Transportadora
     , COALESCE(vl_DIFAL, 0.0000)                                                                                  AS vl_DIFAL
     , NM_SISTEMA                                                                                                  AS NM_SISTEMA
     , NM_SERVIDOR                                                                                                 AS NM_SERVIDOR
     , NM_AMBIENTE                                                                                                 AS NM_AMBIENTE
     , sys_InsertedAt                                                                                              AS sys_InsertedAt
     FROM tmp_view_fat_NotasClientes_Protheus_tmp FT