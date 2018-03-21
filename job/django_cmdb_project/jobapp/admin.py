from django.contrib import admin
from jobapp.models import DynamicGroup , SaltGroup , ExecUser, CustomScript
# Register your models here.



admin.site.register(DynamicGroup)
admin.site.register(SaltGroup)
admin.site.register(ExecUser)
admin.site.register(CustomScript)

