import pandas as pd
import sqlalchemy as sa
from sqlalchemy import orm
import ocorrencias as entities

engine = sa.create_engine('sqlite:///db/delegacia.db')

Session = orm.sessionmaker(bind=engine)
session = Session()

result = session.query(
    entities.Municipio.cod_ibge,
    entities.Municipio.municipio,
    entities.Ocorrencia.ocorrencia,
    sa.func.sum(entities.Ocorrencia.qtde).label('qtde')
).join(
    entities.Ocorrencia,
    entities.Ocorrencia.cod_ibge == entities.Municipio.cod_ibge
).where(
    entities.Ocorrencia.ocorrencia == 'roubo_veiculo'
).order_by(
    sa.func.sum(entities.Ocorrencia.qtde).label('qtde').desc()
).group_by(
    entities.Municipio.cod_ibge,
    entities.Municipio.municipio,
    entities.Ocorrencia.ocorrencia
)

print(pd.DataFrame(result))
