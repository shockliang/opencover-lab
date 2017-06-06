using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace OpenCoverLab.Controllers
{
    public class TodosController : Controller
    {
        // GET: Todos
        public ActionResult Index(int value)
        {
            if(value > 10)
            {
                ContentResult cr = new ContentResult();
                cr.ContentType = "text/html";
                cr.Content = $"Value:{value} greate than 10";

                return cr;
            }
            else {
                return View();
            }
        }
    }
}