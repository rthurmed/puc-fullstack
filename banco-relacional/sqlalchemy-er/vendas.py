import sqlalchemy as sa
from sqlalchemy import orm

engine = sa.create_engine('sqlite:///db/vendas.db')

Base = orm.declarative_base()


class Cliente(Base):
    __tablename__ = 'clientes'

    cpf = sa.Column(sa.CHAR(14), primary_key=True, index=True)
    nome = sa.Column(sa.VARCHAR(100), nullable=False)
    email = sa.Column(sa.VARCHAR(50), nullable=False)
    faixa_salarial = sa.Column(sa.DECIMAL(10, 2))
    dia_mes_aniversario = sa.Column(sa.CHAR(5))
    genero = sa.Column(sa.CHAR(1))
    bairro = sa.Column(sa.VARCHAR(50))
    cidade = sa.Column(sa.VARCHAR(50))
    uf = sa.Column(sa.CHAR(2))


class Fornecedor(Base):
    __tablename__ = 'fornecedores'

    registro_fornecedor = sa.Column(sa.INTEGER, primary_key=True, index=True)
    nome_fantasia = sa.Column(sa.VARCHAR(100), nullable=False)
    razao_social = sa.Column(sa.VARCHAR(100), nullable=False)
    cidade = sa.Column(sa.VARCHAR(50), nullable=False)
    uf = sa.Column(sa.CHAR(2), nullable=False)


class Produto(Base):
    __tablename__ = 'produtos'

    cod_barras = sa.Column(sa.INTEGER, primary_key=True, index=True)
    registro_fornecedor = sa.Column(sa.INTEGER, sa.ForeignKey('fornecedores.registro_fornecedor', ondelete='NO ACTION',
                                                              onupdate='NO ACTION'), nullable=False)
    dsc_produto = sa.Column(sa.VARCHAR(100), nullable=False)
    genero = sa.Column(sa.CHAR(1))


class Vendedor(Base):
    __tablename__ = 'vendedores'

    registro_vendedor = sa.Column(sa.INTEGER, primary_key=True, index=True)
    cpf = sa.Column(sa.CHAR(14), nullable=False)
    nome = sa.Column(sa.VARCHAR(100), nullable=False)
    genero = sa.Column(sa.CHAR(4))
    email = sa.Column(sa.VARCHAR(50))


class Venda(Base):
    __tablename__ = 'vendas'

    id_transacao = sa.Column(sa.INTEGER, primary_key=True, index=True)
    cpf = sa.Column(sa.CHAR(14), sa.ForeignKey('clientes.cpf', ondelete='NO ACTION', onupdate='NO ACTION'),
                    nullable=False, index=True)
    registro_vendedor = sa.Column(sa.INTEGER, sa.ForeignKey('vendedores.registro_vendedor', ondelete='NO ACTION',
                                                            onupdate='NO ACTION'), nullable=False, index=True)
    cod_barras = sa.Column(sa.INTEGER, sa.ForeignKey('produtos.cod_barras', ondelete='NO ACTION', onupdate='NO ACTION'),
                           nullable=False, index=True)
    vlr_venda = sa.Column(sa.DECIMAL(10, 2), nullable=False)
    data_hora_venda = sa.Column(sa.DATETIME, nullable=False)


try:
    Base.metadata.create_all(engine)  # cria as tabelas
    print('tabelas criadas!')
except ValueError:
    ValueError()
