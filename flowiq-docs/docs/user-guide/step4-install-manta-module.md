# Step 4: Install the Manta Module

Inside your new pipeline folder, run:
```
nf-core modules install manta/germline
```

This will add the module to your project and update your `modules.json`.

<p align="left">
   <img src="../assets/demo-manta.gif", width="100%" />
</p>


 > 💡 **Notice at the end of the GIF:** it shows how to include the module in your workflow using the following line:

```
include { MANTA_GERMLINE } from `../modules/nf-core/manta/germline/main`
```

Now let's build a simple pipeline using this Manta module.
