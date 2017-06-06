using Microsoft.VisualStudio.TestTools.UnitTesting;
using OpenCoverLab.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace OpenCoverLab.Controllers.Tests
{
    [TestClass()]
    public class TodosControllerTests
    {
        [TestMethod()]
        public void IndexTest_Should_Be_Return_Text_When_Value_Greate_Than_10()
        {
            // Arrange
            TodosController controller = new TodosController();

            // Act
            //ViewResult result = controller.Index(100) as ViewResult;
            ContentResult cr = controller.Index(100) as ContentResult;

            // Assert
            Assert.IsNotNull(cr);
        }
    }
}