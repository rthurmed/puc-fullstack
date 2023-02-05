import sqlalchemy as sa
from sqlalchemy import orm

engine = sa.create_engine('sqlite:///db/delegacia.db')

Base = orm.declarative_base()


class DP(Base):
    __tablename__ = 'dps'

    cod_dp = sa.Column(sa.INTEGER, primary_key=True, index=True)
    nome = sa.Column(sa.VARCHAR(100), nullable=False)
    endereco = sa.Column(sa.VARCHAR(255), nullable=False)


class Responsavel(Base):
    __tablename__ = 'responsaveis'

    cod_dp = sa.Column(sa.INTEGER, sa.ForeignKey('dps.cod_dp', ondelete='NO ACTION', onupdate='NO ACTION'),
                       primary_key=True, index=True)
    delegado = sa.Column(sa.VARCHAR(100), nullable=False)


class Municipio(Base):
    __tablename__ = 'municipios'

    cod_ibge = sa.Column(sa.INTEGER, primary_key=True, index=True)
    municipio = sa.Column(sa.VARCHAR(100), nullable=False)
    regiao = sa.Column(sa.VARCHAR(25), nullable=False)


class Ocorrencia(Base):
    __tablename__ = 'ocorrencias'

    id_registro = sa.Column(sa.INTEGER, primary_key=True, index=True)
    cod_dp = sa.Column(sa.INTEGER, sa.ForeignKey('dps.cod_dp', onupdate='CASCADE', ondelete='NO ACTION'),
                       nullable=False)
    cod_ibge = sa.Column(sa.INTEGER, sa.ForeignKey('municipios.cod_ibge', onupdate='CASCADE', ondelete='NO ACTION'),
                         nullable=False)
    ano = sa.Column(sa.CHAR(4), nullable=False)
    mes = sa.Column(sa.CHAR(2), nullable=False)
    ocorrencia = sa.Column(sa.VARCHAR(100), nullable=False)
    qtde = sa.Column(sa.INTEGER, nullable=False)


try:
    Base.metadata.create_all(engine)  # cria as tabelas
    print('tabelas criadas!')
except ValueError:
    ValueError()
