from django.contrib import admin
from .models import tb_membresias,tb_personas, tb_miembros, tb_usuarios, tb_membresias_usuarios

# Register your models here.
admin.site.register(tb_membresias)
admin.site.register(tb_personas)
admin.site.register(tb_miembros)
admin.site.register(tb_usuarios)
admin.site.register(tb_membresias_usuarios)

