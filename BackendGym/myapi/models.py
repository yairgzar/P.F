from django.db import models
from django.utils import timezone

class tbl_cliente(models.Model):
	d_nombre = models.CharField(max_length=50)
	d_apellidoPaterno = models.CharField(max_length=50)
	d_apellidoMaterno = models.CharField(max_length=50)
	d_direccion = models.CharField(max_length=150)
	d_telefono = models.CharField(max_length=15)
	d_correo = models.CharField(max_length=100)
	d_contrasena = models.CharField(max_length=50)
	#website = models.URLField(max_length=100)
	#foundation = models.PositiveIntegerField()
    #TextField(blanck=True)
	def _str_(self):
		return self.d_nombre
	
class tbl_rol(models.Model):
	ro_nombre = models.CharField(max_length=50)
	#website = models.URLField(max_length=100)
	#foundation = models.PositiveIntegerField()
    #TextField(blanck=True)
	def _str_(self):
		return self.ro_nombre

class tb_membresias(models.Model):
    codigo = models.CharField(max_length=50)
    tipo = models.CharField(max_length=20, choices=(
		('Individual', 'Individual'),
		('Familiar', 'Familiar'),
		('Empresearial', 'Empresarial')
	))
    tipo_servicios = models.CharField(max_length=20, choices=(
		('Basicos', 'Basicos'),
   		('Completa','Completa'),
     	('Coaching', 'Coaching'),
      	('Nutriólogo', 'Nutriólogo')
	))
    tipo_plan = models.CharField(max_length=20, choices=(
		('Anual','Anual'),
   		('Semestral','Semestral'),
      	('Trimestral','Trimestral'),
        ('Bimestral','Bimestral'),
        ( 'Mensual','Mensual'),
        ( 'Semanal','Semanal'),
        ( 'Diaria','Diaria')
	))
    nivel = models.CharField(max_length=20, choices=(
		('Nuevo','Nuevo'),
   		( 'Plata','Plata'),
   		( 'Oro','Oro'),
   		( 'Diamante','Diamante')
	))
    fecha_inicio = models.DateTimeField(auto_now_add=True)
    fecha_fin = models.DateTimeField(auto_now_add=True)
    estatus = models.BooleanField()
    fecha_registro = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now_add=True)
    

class tb_personas(models.Model):
    titulo_cortecia = models.CharField(max_length=20)
    nombre = models.CharField(max_length=80)
    primer_apellido = models.CharField(max_length=80)
    segundo_apellido = models.CharField(max_length=80)
    fecha_nacimiento = models.DateTimeField(auto_now=True)
    fotografia = models.CharField(max_length=100)
    genero = models.CharField(max_length=20, choices=(
        ("Masculino", "M"),
        ("Femenino", "F"),
        ("No Binario", "N/B"),
    ), default="Masculino")
    tipo_sangre = models.CharField(max_length=10, choices=(
        ("A+", "A+"),
        ("A-", "A-"),
        ("B+", "B+"),
        ("B-", "B-"),
        ("AB+", "AB+"),
        ("AB-", "AB-"),
        ("O+", "O+"),
        ("O-", "O-"),
    ), default="A+")
    estatus = models.BooleanField(default=True)
    fecha_registro = models.DateTimeField(auto_now=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)
    class Meta:
        db_table = 'personas'
    

class tb_miembros(models.Model):
    personas_ID = models.ForeignKey(tb_personas, on_delete=models.CASCADE) 
    membresias_activa = models.BooleanField()
    antiguedad = models.CharField(max_length=50)
    
class tb_usuarios(models.Model):
    Persona_ID = models.OneToOneField(tb_personas, on_delete=models.CASCADE, primary_key=True)
    Nombre_Usuario = models.IntegerField(unique=True)
    Password = models.BinaryField(null=True)
    Tipo = models.CharField(max_length=20, choices=(('Empleado', 'Empleado'), ('Visitante', 'Visitante'), ('Miembro', 'Miembro'), ('Instructor', 'Instructor')), null=True)
    Estatus_Conexion = models.CharField(max_length=10, choices=(('Online', 'Online'), ('Offline', 'Offline'), ('Banned', 'Banned')), null=True)
    Ultima_Conexion = models.DateTimeField(null=True)
    
class tb_membresias_usuarios(models.Model):
    membresias_ID = models.ForeignKey(tb_membresias, on_delete=models.CASCADE) 
    usuarios_ID = models.ForeignKey(tb_usuarios, on_delete=models.CASCADE)
    fecha_Ultima_Visita = models.DateTimeField(auto_now_add=True)
    estatus = models.BooleanField()