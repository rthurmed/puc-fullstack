import pandas as pd
import sqlalchemy as sa
from sqlalchemy import orm
from pathlib import Path
import ocorrencias as entities

# SETUP
data_folder = f'{Path(__file__).parent.absolute()}/dados/BD_Ocorrencias'

engine = sa.create_engine('sqlite:///db/delegacia.db')

Session = orm.sessionmaker(bind=engine)
session = Session()

# DP
data_dps = pd.read_csv(f'{data_folder}/DP.csv')
dataframe_dps = pd.DataFrame(data_dps)

for i in range(len(dataframe_dps)):
    entity_dp = entities.DP(
        cod_dp=int(dataframe_dps['codDP'][i]),
        nome=dataframe_dps['nmDP'][i],
        endereco=dataframe_dps['enderecoDP'][i]
    )
    try:
        session.add(entity_dp)
        session.commit()
    except ValueError:
        print(ValueError())

print('inseridos dados de DP')

# MUNICIPIOS

data_municipios = pd.read_csv(f'{data_folder}/Municipio.csv')
dataframe_municipios = pd.DataFrame(data_municipios)

for i in range(len(dataframe_municipios)):
    entity_municipio = entities.Municipio(
        cod_ibge=int(dataframe_municipios['codIBGE'][i]),
        municipio=dataframe_municipios['municipio'][i],
        regiao=dataframe_municipios['regiao'][i]
    )
    try:
        session.add(entity_municipio)
        session.commit()
    except ValueError:
        print(ValueError())

print('inseridos dados de Municipios')

# RESPONSAVEL

data_responsavel = pd.read_excel(f'{data_folder}/ResponsavelDP.xlsx')
dataframe_responsavel = pd.DataFrame(data_responsavel)
dataframe_responsavel.rename(columns={'codDP': 'cod_dp'}, inplace=True)

dataframe_responsavel.to_sql(
    name=entities.Responsavel.__tablename__,
    con=engine,
    if_exists='append',
    index=False
)

print('inseridos dados de Responsaveis')

# OCORRENCIA

data_ocorrencia = pd.read_excel(f'{data_folder}/ocorrencias.xlsx')
dataframe_ocorrencia = pd.DataFrame(data_ocorrencia)
dataframe_ocorrencia.rename(columns={
    'idRegistro': 'id_registro',
    'codDP': 'cod_dp',
    'codIBGE': 'cod_ibge'
}, inplace=True)

dataframe_ocorrencia.to_sql(
    name=entities.Ocorrencia.__tablename__,
    con=engine,
    if_exists='append',
    index=False
)

print('inseridos dados de Ocorrencias')

# END

session.close_all()
