const sectionIds = [
  '#home',
  '#about',
  '#skills',
  '#work',
  '#testimonial',
  '#contact',
  '#Overview',
  '#Data',
  '#Code',
  '#Results',
  '#clustering',
  '#clustering_overview',
  '#clustering_data',
  '#clustering_code',
  '#clustering_results',
  '#clustering_conclusion',
  '#PCA',
  '#PCA_overview',
  '#PCA_data',
  '#PCA_code',
  '#PCA_results',
  '#PCA_conclusion',
  '#Naïve_Bayes',
  '#Naïve_Bayes_overview',
  '#Naïve_Bayes_data',
  '#Naïve_Bayes_code',
  '#Naïve_Bayes_results',
  '#Naïve_Bayes_conclusion',
  '#Decision_Tree',
  '#Decision_Tree_overview',
  '#Decision_Tree_data',
  '#Decision_Tree_code',
  '#Decision_Tree_results',
  '#Decision_Tree_conclusion',
  '#SVM',
  '#SVM_overview',
  '#SVM_data',
  '#SVM_code',
  '#SVM_results',
  '#SVM_conclusion',
  '#Neural Networks',
  '#Neural Networks_overview',
  '#Neural Networks_data',
  '#Neural Networks_code',
  '#Neural Networks_results',
  '#Neural Networks_conclusion',
  '#Regression',
  '#Regression_overview',
  '#Regression_data',
  '#Regression_code',
  '#Regression_results',
  '#Regression_conclusion'
];
const sections = sectionIds.map((id) => document.querySelector(id));
const navItems = sectionIds.map((id) =>
  document.querySelector(`[href="${id}"]`)
);

const visibleSections = sectionIds.map(() => false);
let activeNavItem = navItems[0];

const options = {
  rootMargin: '-20% 0px 0px 0px',
  threshold: [0, 0.98],
};
const observer = new IntersectionObserver(observerCallback, options);
sections.forEach((section) => observer.observe(section));

function observerCallback(entries) {
  let selectLastOne;
  entries.forEach((entry) => {
    const index = sectionIds.indexOf(`#${entry.target.id}`);
    visibleSections[index] = entry.isIntersecting;
    selectLastOne =
      index === sectionIds.length - 1 &&
      entry.isIntersecting &&
      entry.intersectionRatio >= 0.95;
  });

  const navIndex = selectLastOne
    ? sectionIds.length - 1
    : findFirstIntersecting(visibleSections);
  selectNavItem(navIndex);
}

function findFirstIntersecting(intersections) {
  const index = intersections.indexOf(true);
  return index >= 0 ? index : 0;
}

function selectNavItem(index) {
  const navItem = navItems[index];
  if (!navItem) return;
  activeNavItem.classList.remove('active');
  activeNavItem = navItem;
  activeNavItem.classList.add('active');
}
